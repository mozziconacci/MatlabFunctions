function z=PDBConnect(pdb)
z=pdb;
n=length(pdb.Model.Atom);
for i = 1:n
z.Connectivity(i).AtomSerNo=i;
z.Connectivity(i).BondAtomList=i+1;
end
end