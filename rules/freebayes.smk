from os import path


rule freebayes:
    input:
        samples=expand('bam/final/{sample}.bam', sample=get_samples()),
        indices=expand('bam/final/{sample}.bam.bai', sample=get_samples()),
    output:
        'vcf/calls.vcf'
    params:
        reference=config['freebayes']['reference'],
        targets=config['freebayes']['targets'],
        extra=config['freebayes']['extra']
    log:
        'logs/freebayes.log'
    conda:
        path.join(workflow.basedir, 'envs/freebayes.yaml')
    shell:
        'freebayes {params.extra} --fasta-reference {params.reference}'
        ' --targets {params.targets} {input.samples} > {output[0]} 2> {log}'
