% Stability optimisation based on a greedy agglomerative method.
% Time continuous Markov process version with a single time value only.
%
% Input
%   - adj: (symmetrical) adjacency matrix
%   - t  : Markov time to consider
%
% Output
%   - com: communities (listed for each node)
%   - Q  : stability value of the given partition
%
% Author: Erwan Le Martelot
% Date: 13/06/11

function [com,Q] = gso_continuous_t(adj, t)

    % Compute initial indicator matrix
    H = diag(ones(1,length(adj)));

    % Nodes degree (line) vector
    d = sum(adj,2)';

    % Transition matrix M
    %M = inv(diag(d)) * adj;
    M = diag(d) \ adj;
    
    % Markov chain transition probabilities (line) vector
    pi = d / sum(d);

    % Markov chain transition probabilities diagonal matrix
    PI = diag(pi);

    % Compute community matrix e(t)
    E = H' * PI * expm((M-eye(length(M)))*t) * H;

    % Set initial communities with one node per community
    cur_com = [ 1:length(adj) ]';

    % Initialise best community to current value
    com = cur_com;

    % Compute initial community matrix
    e = get_community_matrix(adj,com);
    
    % Lines and columns sum (speed optimisation)
    ls = sum(e,2);
    cs = sum(e,1);

    % Initial Q value
    Q = compute_stability(M,H,pi,PI,t);
    cur_Q = Q;
    
    % Loop until no more aggregation is possible
    while length(e) > 1

        % Print progress
        %fprintf('Loop %d/%d...',length(adj)-length(e)+1,length(adj));
        %tic

        % Best Q found in the current loop
        loop_best_dQ = -inf;

        % For all the pairs of nodes that could be merged
        can_merge = false;
        for i=1:length(e)
            for j=i+1:length(e)
                % If they share edges
                if e(i,j) > 0
                    dQ = 2 * (E(i,j) - (ls(i))*(cs(j)));
                    if dQ > loop_best_dQ
                        loop_best_dQ = dQ;
                        best_pair = [i,j];
                        can_merge = true;
                    end
                end
            end
        end
        if ~can_merge
            disp('!!! Graph with isolated communities, no more merging possible !!!');
            break;
        end

        % Merge the pair of clusters maximising Q
        best_pair = sort(best_pair);
        for i=1:length(cur_com)
            if cur_com(i) == best_pair(2)
                cur_com(i) = best_pair(1);
            elseif cur_com(i) > best_pair(2)
                cur_com(i) = cur_com(i) - 1;
            end
        end

        % Update community matrices
        E(best_pair(1),:) = E(best_pair(1),:) + E(best_pair(2),:);
        E(:,best_pair(1)) = E(:,best_pair(1)) + E(:,best_pair(2));
        E(best_pair(2),:) = [];
        E(:,best_pair(2)) = [];
        e(best_pair(1),:) = e(best_pair(1),:) + e(best_pair(2),:);
        e(:,best_pair(1)) = e(:,best_pair(1)) + e(:,best_pair(2));
        e(best_pair(2),:) = [];
        e(:,best_pair(2)) = [];
        % Update lines/colums sum
        ls(best_pair(1)) = ls(best_pair(1)) + ls(best_pair(2));
        cs(best_pair(1)) = cs(best_pair(1)) + cs(best_pair(2));
        ls(best_pair(2)) = [];
        cs(best_pair(2)) = [];

        % Update Q value
        cur_Q = cur_Q + loop_best_dQ;

%         % Check consistency
%         eqQ = compute_stability(M,get_indicator_matrix(adj,cur_com),pi,PI,t1,dt,t2);
%         if abs(loop_best_Q - eqQ) >= 0.00001
%            fprintf('Warning: found Q=%f, should be Q=%f. Diff = %f\n',loop_best_Q,eqQ,abs(loop_best_Q-eqQ));
%         end

        % If new Q is better, save current partition
        if cur_Q > Q
            Q = cur_Q;
            com = cur_com;
        end

%         fprintf(' completed in %f(s)\n',toc);

    end

end

% Computation of stability
function [Q,QV] = compute_stability(M,H,pi,PI,ts)

    Q = 1;
    QV = [];
    for i=1:length(ts)
        Rs = H' * ( PI * expm((M-eye(length(M)))*ts(i)) - pi' * pi ) * H;
        Q_tmp = trace(Rs);
        if (Q_tmp < Q)
            Q = Q_tmp;
        end
        QV(length(QV)+1) = Q_tmp;
    end

end
