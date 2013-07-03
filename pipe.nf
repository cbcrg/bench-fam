#!/usr/bin/env nextflow

params.in = 'tutorial/sample.fasta'
params.pdb_db='/db/pdb/derived_data_format/blast/latest/pdb_seqres.fa'
params.pdb_dir='/db/pdb/data/structures/divided/pdb'
params.largeScaleMethods = 'mafft clustalo'
params.structuralAligners = 'sap mustang TMalign'
params.normalAligners = 'tcoffee mcoffee psicoffee 3Dmcoffee sap_proba mustang_proba tmalign_proba clustalw mafft msaprobs muscle prank probcons sate'


fasta = channel( file(params.in))

structural_fasta = list()
structural_template = list()

task('pdb-extract') {
  input fasta
  output 'modified.fasta': structural_fasta 
  output 'modified.template': structural_template
  echo true

  """ 
  export PDB_DIR=${params.pdb_dir}

  t_coffee $fasta  -mode expresso -blast=LOCAL -pdb_db=${params.pdb_db} -pdb_type d -pdb_min_sim 95 -pdb_min_cov 95 -cache \$PWD
  grep _P_  *_pdb1.template_list > temp.list
  t_coffee -other_pg seq_reformat -in $fasta -action +extract_seq_list temp.list > temp.fasta

  PDB_extract.pl
  
  """
}


structural_lib_names = params.structuralAligners .split(' ').collect { it + ".lib" }.join(' ') 

task('create-structural-lib') {
  input structural_fasta 
  input structural_template
  output structural_outlib
  echo true

  """

  for alx in ${params.structuralAligners}; do 
    t_coffee ${structural_fasta} -template_file ${structural_template} -method \${alx}_pair  -out_lib \${alx}.lib 
  done 

  t_coffee -lib ${structural_lib_names} -output sp_ascii -outfile structural_outlib
  """
}



large_msa_out = channel()

task("Large-scale MSAs"){
    input structural_fasta   
    output '*.fa': large_msa_out

    """
    for m in ${params.largeScaleMethods}; do
      x-align \$m ${structural_fasta} \$m.fa
    done
    """

}


inLib = structural_outlib.val

task('extract sub-aln in Large MSAs') {
  input large_msa_out   

  """
  extract_subAln.pl ${inLib} ${large_msa_out}
  """

}
