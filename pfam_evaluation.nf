#!/usr/env nextflow
params.largeScalePath='./tutorial/fam'

largeScalePath = file(params.largeScalePath)
//largeScalePath=file("/users/cn/mhatzou/Datasets/PFAM_25/fam_largeScaleData_Cedric")
aln_threads=3

methods = ['mafft','clustalo']
famNames="PF00004 PF00005 PF00006 PF00008 PF00013 PF00014 PF00016 PF00017 PF00018 PF00019 PF00020 PF00023 PF00025 PF00026 PF00027 PF00028 PF00030 PF00034 PF00036 PF00037 PF00040 PF00041 PF00042 PF00043 PF00044 PF00045 PF00046 PF00047 PF00048 PF00051 PF00056 PF00059 PF00061 PF00062 PF00067 PF00068 PF00069 PF00070 PF00071 PF00072 PF00073 PF00074 PF00075 PF00076 PF00077 PF00079 PF00080 PF00081 PF00082 PF00084 PF00085 PF00087 PF00089 PF00092 PF00096 PF00102 PF00104 PF00105 PF00106 PF00107 PF00109 PF00111 PF00112 PF00113 PF00116 PF00117 PF00121 PF00125 PF00127 PF00128 PF00129 PF00132 PF00134 PF00139 PF00141 PF00144 PF00147 PF00149 PF00150 PF00152 PF00155 PF00156 PF00160 PF00161 PF00162 PF00167 PF00168 PF00169 PF00171 PF00175 PF00179 PF00180 PF00185 PF00186 PF00187 PF00190 PF00191 PF00194 PF00197 PF00199 PF00200 PF00202 PF00205 PF00206 PF00208 PF00210 PF00211 PF00215 PF00217 PF00227 PF00228 PF00229 PF00230 PF00232 PF00233 PF00235 PF00238 PF00240 PF00241 PF00246 PF00248 PF00254 PF00255 PF00258 PF00266 PF00268 PF00270 PF00271 PF00285 PF00288 PF00289 PF00291 PF00293 PF00294 PF00296 PF00300 PF00303 PF00306 PF00307 PF00318 PF00326 PF00328 PF00331 PF00334 PF00337 PF00342 PF00347 PF00348 PF00352 PF00355 PF00370 PF00373 PF00378 PF00383 PF00384 PF00385 PF00389 PF00392 PF00394 PF00400 PF00405 PF00406 PF00407 PF00412 PF00413 PF00415 PF00431 PF00432 PF00435 PF00439 PF00440 PF00441 PF00445 PF00448 PF00452 PF00456 PF00457 PF00459 PF00462 PF00463 PF00465 PF00467 PF00480 PF00483 PF00484 PF00491 PF00496 PF00497 PF00501 PF00502 PF00514 PF00515 PF00531 PF00532 PF00533 PF00534 PF00537 PF00541 PF00545 PF00550 PF00551 PF00554 PF00557 PF00560 PF00561 PF00571 PF00575 PF00576 PF00578 PF00579 PF00581 PF00583 PF00586 PF00587 PF00588 PF00590 PF00591 PF00595 PF00615 PF00621 PF00622 PF00626 PF00627 PF00628 PF00630 PF00644 PF00652 PF00653 PF00657 PF00670 PF00675 PF00680 PF00682 PF00685 PF00696 PF00698 PF00701 PF00702 PF00704 PF00705 PF00710 PF00719 PF00722 PF00724 PF00730 PF00740 PF00753 PF00754 PF00756 PF00775 PF00782 PF00787 PF00795 PF00806 PF00856 PF00857 PF00866 PF00881 PF00884 PF00885 PF00890 PF00891 PF00903 PF00905 PF00929 PF00936 PF00963 PF00969 PF00970 PF00989 PF00993 PF00994 PF01011 PF01023 PF01030 PF01037 PF01041 PF01042 PF01047 PF01048 PF01053 PF01063 PF01094 PF01118 PF01123 PF01138 PF01161 PF01168 PF01177 PF01180 PF01182 PF01187 PF01188 PF01193 PF01230 PF01239 PF01243 PF01248 PF01261 PF01263 PF01266 PF01315 PF01323 PF01327 PF01336 PF01344 PF01353 PF01370 PF01380 PF01381 PF01408 PF01419 PF01421 PF01423 PF01436 PF01451 PF01467 PF01477 PF01479 PF01487 PF01494 PF01497 PF01510 PF01546 PF01547 PF01564 PF01565 PF01568 PF01571 PF01588 PF01590 PF01593 PF01613 PF01627 PF01656 PF01661 PF01728 PF01791 PF01799 PF01833 PF01842 PF01850 PF01965 PF01966 PF01979 PF02085 PF02136 PF02210 PF02310 PF02332 PF02518 PF02525 PF02566 PF02597 PF02627 PF02629 PF02635 PF02729 PF02738 PF02746 PF02769 PF02770 PF02771 PF02774 PF02775 PF02776 PF02777 PF02779 PF02780 PF02782 PF02784 PF02788 PF02797 PF02798 PF02800 PF02801 PF02803 PF02806 PF02807 PF02812 PF02826 PF02832 PF02837 PF02852 PF02861 PF02866 PF02874 PF02875 PF02876 PF02878 PF02881 PF02885 PF02894 PF02907 PF03009 PF03061 PF03070 PF03099 PF03104 PF03129 PF03143 PF03144 PF03167 PF03358 PF03372 PF03422 PF03446 PF03466 PF03471 PF03496 PF03725 PF03727 PF03810 PF03952 PF03989 PF03992 PF04616 PF05191 PF05193 PF05199 PF05221 PF05368 PF05738 PF05932 PF06026 PF06628 PF06696 PF07650 PF07653 PF07654 PF07679 PF07686 PF07687 PF07702 PF07714 PF07715 PF07731 PF07732 PF07859 PF07883 PF07969 PF07980 PF07992 PF08240 PF08241 PF08245 PF08282 PF08447 PF08501 PF08534 PF08541 PF08544 PF08545 PF10535 PF10584 PF12680 PF12681 PF12695 PF12697 PF12796 PF12799 PF12840 PF12847"

splib = file('./tutorial/sp_lib')


fasta = channel()
method = channel() 
aln_out = channel()

largeScalePath.eachFile { File aln ->
  methods.each { 
    method << it
    fasta << aln   
 }
}

fasta << groovyx.gpars.dataflow.operator.PoisonPill.instance

task("Large-scale MSAs"){
    input method
    input fasta  
    output '*.fa': aln_out

    """
    x-align $method $fasta ${method}.fa
    """

}

/* 
 
task ('Extract splib'){


    "extract_subAln.pl $lib_file $lmsa_clustal" 
}

 */
 
 println "Done"