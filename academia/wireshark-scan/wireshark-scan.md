# Using WireShark


we need to capture the interface data, to do that we can use tcpdump to create a file with the trafic and capture the data.
_note:_ use the .cap extension for the filename

```
iwconfig -> look for interfaces 
ipconfig -> look for interfaces

tcpdump -i <interface> -w <fileName.cap> v

```
this will listen all the data in the land interface.

them we can use wireshark to read the file created.


```
wireshark <filename> &>/dev/null & disowm 

```


