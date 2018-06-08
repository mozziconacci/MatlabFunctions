% Stability optimisation based on a multi-step greedy agglomerative method.
% Markov chain (discrete time) version
%
% Input
%   - adj: (symmetrical) adjacency matrix
%   - ts : vector of Markov times to consider
%   - k  : number of pairs to merge per iteration (2)
%
% Output
%   - com: communities (listed for each node)
%   - Q  : stability value of the given partition
%
% Author: Erwan Le Martelot
% Date: 08/04/11

function [com,Q] = msgso_discrete(adj, ts, k)

    % Set default k value to 2
    if nargin < 3
        k = 2;
    end

    % Compute initial indicator matrix
    H = diag(ones(1,length(adj)));

    % Nodes degree (line) vector
    d = sum(adj,2)';

    % Transition matrix M
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
    cur_com = [ 1:length(adj) ]';

    % Initialise best community to current value
    com = cur_com;

    % Initial Q value
    [Q, cur_QV] = compute_stability(M,H,pi,PI,ts);

    % Loop until no more aggregation is possible
    while length(e) > 1

        % Print progress
        %fprintf('Loop %d/%d...',length(adj)-length(e)+1,length(adj));
        %tic

        % For all the pairs of nodes that could be merged
        pairs = [];
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
                    tmp_Q = min(tmp_QV);
                    if tmp_Q > min(cur_QV)
                        pairs = [pairs; i j tmp_Q dQV];
                    end
                end
            end
        end
        
        % Test that merging is possible
        if isempty(pairs)
            fprintf('No more dQ>0 - %d communities left\n', length(e));
            break;
        end
        % Sort the pairs based on their Q
        pairs = sortrows(pairs,-3);
        % Merge the k best pairs that do not overlap
        for p=1:k
            if isempty(pairs)
                fprintf('No more merging possible at %d out of %d\n', p, k);
                break;
            else
                cur_pair = [pairs(1,1), pairs(1,2)];
                cur_pair = sort(cur_pair);
                q = pairs(1,3);
                % Merge the current pair
                for i=1:length(cur_com)
                    if cur_com(i) == cur_pair(2)
                        cur_com(i) = cur_pair(1);
                    elseif cur_com(i) > cur_pair(2)
                        cur_com(i) = cur_com(i) - 1;
                    end
                end
                % Update community matrix
                for s=1:length(E)
                    E{s}(cur_pair(1),:) = E{s}(cur_pair(1),:) + E{s}(cur_pair(2),:);
                    E{s}(:,cur_pair(1)) = E{s}(:,cur_pair(1)) + E{s}(:,cur_pair(2));
                    E{s}(cur_pair(2),:) = [];
                    E{s}(:,cur_pair(2)) = [];
                end
                e(cur_pair(1),:) = e(cur_pair(1),:) + e(cur_pair(2),:);
                e(:,cur_pair(1)) = e(:,cur_pair(1)) + e(:,cur_pair(2));
                e(cur_pair(2),:) = [];
                e(:,cur_pair(2)) = [];
                % Update lines/colums sum
                ls(cur_pair(1)) = ls(cur_pair(1)) + ls(cur_pair(2));
                cs(cur_pair(1)) = cs(cur_pair(1)) + cs(cur_pair(2));
                ls(cur_pair(2)) = [];
                cs(cur_pair(2)) = [];
                
                % Update QV value
                cur_QV = cur_QV + pairs(1,4:length(pairs(1,:)));
                % Test current stability
                cur_Q = min(cur_QV);
                if cur_Q > Q
                    Q = cur_Q;
                    com = cur_com;
                end
                % Delete pairs that overlap and update indices
                j = 1;
                while j <= size(pairs,1)
                    if (pairs(j,1) == cur_pair(1)) || (pairs(j,1) == cur_pair(2)) || ...
                       (pairs(j,2) == cur_pair(1)) || (pairs(j,2) == cur_pair(2))
                        pairs(j,:) = [];
                    else
                        if pairs(j,1) > cur_pair(2)
                            pairs(j,1) = pairs(j,1) - 1;
                        end
                        if pairs(j,2) > cur_pair(2)
                            pairs(j,2) = pairs(j,2) - 1;
                        end
                        j = j + 1;
                    end
                end
            end      
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
