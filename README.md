s3wipe
======

A rapid parallelized AWS S3 bucket &amp; key deleter.

I was recently tasked with deleting an bucket in Amazon's Simple Storage 
Service (S3) that contained an absolutely massive number of files.

Unfortunately, Amazon themselves do not give you an easy way to do this 
yourself.  Their web interface stalls indefinitely when you delete an
"adequately large" number of files, and their CLI tool (aptly named 
"aws-cli") only deletes files in a single-threaded fashion.

After googling around a bit, I encountered 
[s3nukem](https://github.com/lathanh/s3nukem) (itself a fork
of [s3nuke](http://github.com/SFEley/s3nuke/)), which appeared to be the
solution to my problems.  After a few minutes of trying to find the 
'right' version of RightAWS (the s3nukem code & readme had a
disagreement over this), I was able to get it up and running.  However,
after a bit back-of-the-napkin math, it was looking like it was still
going to take at least a month of running s3nukem before the bucket was 
deleted. 

So, I wrote s3wipe.  S3wipe, as far as I know, is the only S3 bucket 
deletion tool that:

* Does parallel, thread-based delete AND list operations (more speed)
* Performs batch deletes (MOAR SPEED!)
* Will delete versioned objects (MOAR... well, deletes)

Using s3wipe, I was able to delete _400 million S3 objects in about 24 hours_.

## Installation

This is just a single-file script, so just go ahead and run it.  It will need
a semi-recent version of the "boto" python module to be installed, though, so:

    pip install boto

_or_

    yum install python-boto

_or_

    apt-get install python-boto

Then:

    wget https://raw.github.com/lathanh/s3nukem/master/s3nukem
    chmod 755 s3wipe
    
## Usage

```
usage: s3wipe [-h] --bucket BUCKET --id ID --key KEY [--quiet]     
              [--batchSize BATCHSIZE] [--maxQueue MAXQUEUE]        
                                                                   
Delete all keys in an S3 bucket                                    
                                                                   
optional arguments:                                                
  -h, --help             show this help message and exit           
  --bucket BUCKET        Bucket name to delete                     
  --id ID                Your AWS access key ID                    
  --key KEY              Your AWS secret access key                
  --quiet                Suprress all non-error output             
  --batchSize BATCHSIZE  # of keys to batch delete (default 100)   
  --maxQueue MAXQUEUE    Max size of deletion queue (default 10k)  
```
