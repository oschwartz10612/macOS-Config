
Generate png of stls in folder
```bash
for i in *.stl; do
  T=__tmp__$i
  b=`basename $i`
  echo import\(\"$i\"\)\; >$T
  /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o $b.png --imgsize=1000,1000 $T
  rm $T
done
```

Concatenate video/audio files in folder
```bash
ffmpeg -safe 0 -f concat -i <(for f in `ls $PWD/*.mkv | sort -V`; do echo "file '$f'"; done) -codec copy full.mkv
```
With beep
```bash
ffmpeg -safe 0 -f concat -i <(for f in `ls $PWD/*.m4a | sort -V`; do echo "file '$f'\nfile /Users/owenschwartz/beep.m4a"; done) -codec copy full.m4a
```

Convert with FFMPEG
```bash
ffmpeg -i in.mp4 out.mkv
```