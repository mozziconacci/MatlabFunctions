% Stability optimisation based on a greedy agglomerative method.
% Markov chain (discrete time) version
%
% Input
%   - adj: (symmetrical) adjacency matrix
%   - ts : vector of Markov times to consider
%
% Output
%   - com: communities (listed for each node)
%   - Q  : stability value of the given partition
%
% Author: Erwan Le Martelot
% Date: 06/12/10

function [com,Q] = gso_discrete(adj, ts)

    % Compute initial indicator matrix
    H = diag(ones(1,length(adj)));

    % Nodes degree (line) vector
    d = sum(adj,2)';

    % Transition matrix M = inv(diag(d)) * adj;
    M = diag(d) \ adj;
    
    % Markov chain transition probabilities (line) vector
    pi = d / sum(d);

    % Markov chain transition probabilities diagonal matrix
    PI = diag(pi);

    % Compute community matrices e(t) for integer values of t
    E = [];
    for s=1:length(ts)
        tf = floor(ts(s));
        if ts(s) == tf
            %E{s} = H' * PI * (M^ts(s)) * H;
            E{s} = H' * PI * mpower2(M,ts(s)) * H;
        else
            ds = ts(s) - tf;
            %Mt = mpower(M,tf);
            Mt = mpower2(M,tf);
            E{s} = H' * PI * ((1-ds)*Mt + ds*(Mt*M)) * H;
        end
    end

    % Standard community matrix reflecting the actual edges
    e = H' * PI * M * H;

    % Lines and columns sum (speed optimisation)
    ls = sum(e,2);
    cs = sum(e,1);
    
    % Set initial communities with one node per community
    cur_com = [1:length(adj)]';

    % Initialise best community to current value
    com = cur_com;

    % Initial Q value
    [Q, cur_QV] = compute_stability(M,H,pi,PI,ts);

    % Loop until no more aggregation is possible
    while length(e) > 1

        % Print progress
        %fprintf('Loop %d/%d...',length(adj)-length(e)+1,length(adj));
        %tic

        % Best Q found in the current loop
        loop_best_Q = -inf;

        % For all the pairs of nodes that could be merged
        can_merge = false;
        for i=1:length(e)
            for j=i+1:length(e)
                % If they share edges
                if e(i,j) > 0
                    % Compute the variation in Q for all t
                    for s=1:length(ts)
                        dQV(s) = E{s}(i,j);
                    end
                    dQV = 2 * (dQV - (ls(i))*(cs(j)));
                    tmp_QV = cur_QV + dQV;
                    % If best variation, then keep track of the pair
                    tmp_Q = min(tmp_QV);
                    if tmp_Q > loop_best_Q
                        loop_best_Q = tmp_Q;
                        loop_best_QV = tmp_QV;
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
        %fprintf('(%d %d %g) - ',best_pair(1),best_pair(2),loop_best_Q-cur_QV);
        for i=1:length(cur_com)
            if cur_com(i) == best_pair(2)
                cur_com(i) = best_pair(1);
            elseif cur_com(i) > best_pair(2)
                cur_com(i) = cur_com(i) - 1;
            end
        end

        % Update community matrices
        for s=1:length(E)
            E{s}(best_pair(1),:) = E{s}(best_pair(1),:) + E{s}(best_pair(2),:);
            E{s}(:,best_pair(1)) = E{s}(:,best_pair(1)) + E{s}(:,best_pair(2));
            E{s}(best_pair(2),:) = [];
            E{s}(:,best_pair(2)) = [];
        end
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
        cur_QV = loop_best_QV;

%         % Check consistency
%         eqQ = compute_stability(M,get_indicator_matrix(adj,cur_com),pi,PI,t1,dt,t2);
%         if abs(loop_best_Q - eqQ) >= 0.00001
%            fprintf('Warning: found Q=%f, should be Q=%f. Diff = %f\n',loop_best_Q,eqQ,abs(loop_best_Q-eqQ));
%         end

        % If new Q is better, save current partition
        if loop_best_Q > Q
            Q = loop_best_Q;
            com = cur_com;
        end

%         fprintf(' completed in %f(s)\n',toc);

    end

end

% Computation of stability
function [Q,QV] = compute_stability(M,H,pi,PI,ts)

    Q = 1;
    QV = [];
    for s=1:length(ts)
        ds = ts(s) - floor(ts(s));
        if ds == 0
            Rs = H' * ( PI * (M^ts(s)) - pi' * pi ) * H;
        else
            fts = floor(ts(s));
            RsI = H' * ( PI * (M^fts) - pi' * pi ) * H;
            RsF = H' * ( PI * (M^(fts+1)) - pi' * pi ) * H;
            Rs = (1-ds)*RsI + ds*RsF;
        end
        Q_tmp = trace(Rs);
        if (Q_tmp < Q)
            Q = Q_tmp;
        end
        QV(length(QV)+1) = Q_tmp;
    end

end

% % Computation of stability
% function [Q,QV] = compute_stability_E(E,ts,e_idx,time_idx)
% 
%     Q = 1;
%     QV = [];
%     e = E{e_idx};
%     for s=1:length(ts)
%         ds = ts(s) - floor(ts(s));
%         if ds == 0
%             et = E{time_idx(s)};
%         else
%             et = (1-ds)*E{time_idx(s)} + ds*E{time_idx(s)+1};
%         end
%         sum(sum(et*et))
%         sum(sum(e*e))
%         Q_tmp = trace(et) - sum(sum(e*e));
%         if (Q_tmp < Q)
%             Q = Q_tmp;
%         end
%         QV(length(QV)+1) = Q_tmp;
%     end
%     
% end
