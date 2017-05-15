# Identicon

This is implement for interview question.
Do you know that the Github default personal avatar is generated by your account? 
It’s called “Identicon”. You can read the wiki (https://en.wikipedia.org/wiki/Identicon), then create a ruby gem to generate the identicon .png file by “user_name”, such as:

```Identicon.new(<user_name>).generate```

![alt text](https://github.com/tomohung/interview-identicon/blob/master/sample.png)

This is an identicon, size: 250px * 250px, basic unit: 50px * 50px
Notice: the avatar should always be the same with the same user_name, and be bilateral symmetry

Hint (example):
Get <user_name>
Unpack user_name via MD5 to a hexstring of 32 characters.
Get bytes array from hexstring, take half elements of the array (size: 16)
Pick up [0...3] elements to set up rgb color
Pick up the rest of elements, to decide if the unit should have color or not by it’s odd/even. (there’re 25 units in the example identicon, fill 15 units first)
Mirror it, to fill the rest of units. Then you can get a bilateral symmetry identicon
Generate avatar file and save.

## Try it

$ gem build identicon.gemspec
$ gem install identicon-x.x.x
$ irb
irb> require 'identicon'
irb> Identicon.new(<user_name>).generate

then will ouput a <user_name>.png file

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/identicon.

