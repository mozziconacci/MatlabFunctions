function  interactions = pdbgetcont(ID,threshold)
%PDBDISTPLOT displays distances between residues in a PDB structure.
%
%   PDBDISTPLOT(PDBID) retrieves entry PDBID from the PDB database and
%   creates a heat map showing inter residue distances and a spy plot
%   showing the residues where the minimum distances apart are less than 7
%   Angstroms. PDBID can also be the name of a variable or a file
%   containing a PDB structure.
%    
%   PDBDISTPLOT(PDBID,DIST) allows you to specify the threshold distance in
%   Angstroms to be shown on the spy plot. The default is 7.
%
%   Example:
%
%   % Show spy plot at 7 Angstroms of rat calmodulin-dependent protein
%   % kinase.
%   pdbdistplot('5CYT');
%
%   % Now take a look at 12 Angstroms.
%   pdbdistplot('5CYT',12);
%
%   See also GETPDB, MOLVIEWER, PDBREAD, PROTEINPLOT, PROTEINPROPPLOT,
%   RAMACHANDRAN.

%   Copyright 2003-2009 The MathWorks, Inc.


bioinfochecknargin(nargin,1,mfilename);

if nargin < 2
    threshold = 7;
end

%read the pdb entry
%ID must either a structure, a pdb file, or a valid PDBID.
try
    if (~isstruct(ID))
        if exist(ID,'file')
            pdbstruct = pdbread(ID);
        else
            pdbstruct = getpdb(ID);
        end
    else
        pdbstruct = convertpdbstruct(ID, mfilename);            
    end
catch theErr
    if ~isempty(strfind(theErr.identifier,'getpdb')) 
        rethrow(theErr);
    end
    error(message('bioinfo:pdbdistplot:InvalidInput'));
end

% Threshold must be numeric
if ~isnumeric(threshold)
    error(message('bioinfo:pdbdistplot:NotANumeric'));
end

% Get the first model in pdbstruct
if isfield(pdbstruct, 'Model')
    modelstruct = pdbstruct.Model(1);
else
    error(message('bioinfo:pdbdistplot:NotAtomicCoordinates'));
end

% If there are multiple chains, we will look at them separately
numSequences = numel(pdbstruct.Sequence);

for seq = 1:numSequences
    % get IDs for current chain
    chainID =  pdbstruct.Sequence(seq).ChainID;
    
    % get coords of Atoms and HeterogenAtoms
    chainCoords = [modelstruct.Atom.chainID]' ==chainID;
    
    if isfield(modelstruct, 'HeterogenAtom')
        hetCoords = [modelstruct.HeterogenAtom.chainID]' == chainID;
        % Create Nx3 matrix of 3D coords
        coords = [modelstruct.Atom(chainCoords).X modelstruct.HeterogenAtom(hetCoords).X;
            modelstruct.Atom(chainCoords).Y modelstruct.HeterogenAtom(hetCoords).Y;
            modelstruct.Atom(chainCoords).Z modelstruct.HeterogenAtom(hetCoords).Z; ]';

        order = [modelstruct.Atom(chainCoords).resSeq,...
            modelstruct.HeterogenAtom(hetCoords).resSeq;];

        % reorder the matrix so that any Het atoms that should be intersperced
        % with normal atoms are in the correct order.
        [order, perm] = sort(order);
        coords = coords(perm,:);
    else
        % Create Nx3 matrix of 3D coords
        coords = [modelstruct.Atom(chainCoords).X;
            modelstruct.Atom(chainCoords).Y;
            modelstruct.Atom(chainCoords).Z; ]';
        
        order = [modelstruct.Atom(chainCoords).resSeq];
    end
        
    % calculating and plotting pairwise distances is memory intensive. Stop
    % if we have more than 2000 coordinates.
    if numel(order) > 2000
        % we could break the model up into blocks to deal with the memory
        % required for very large proteins, but even so we will still have to
        % calculate all the pairwise distances which will take a long time.
        if numSequences > 1
            warning(message('bioinfo:pdbdistplot:ChainTooLong', seq));
            continue
        else
            error(message('bioinfo:pdbdistplot:ModelTooBig'))
        end
    end
    
    % make sure that we start counting at 1
    if order(1) < 1
        order = order + (1-order(1));
    end

    % calculate pairwise distances. 
    distances = pdist(coords);
    
    figure('Tag','Bioinfo:pdbdistplot:heatMapFigure');
    % squareform takes pdist output and turns it into a square matrix.
    imagesc(squareform(distances))
    axis image
    title(sprintf('Chain %s: Inter-atomic distances',chainID) );
    
    % figure out which atoms are close
    closeAtoms = distances<threshold;
    [r,c] = find(squareform(closeAtoms));
    
    % use sparse to count how many of each residue are close to others
    interactions = sparse(order(r),order(c),1);
    
    % some hetatoms may be bound elements and not part of the actual
    % protein. We will remove them from the plot as they tend to skew it,
    % however these may be of interest.
    residues = pdbstruct.Sequence(seq).NumOfResidues;
    if residues>min(size(interactions))
        interactions(residues,residues) = 0;
    end
    interactions=interactions(1:residues,1:residues);
    figure('Tag','Bioinfo:pdbdistplot:spyFigure');
    spy(interactions(1:residues,1:residues));
    title(sprintf('Chain %s: Residues less than %.2f Angstroms apart',...
        chainID,threshold));
end


