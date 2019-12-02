# nxtp
Network neXt Time Protocol is an easy way of getting local time on 8-bit computers equipped with wifi or networking. It is similar to the well-known NTP Network Time Protocol, but simpler to use when millisecond precision is not needed.

The server is written in C# using .NET Core 3.0, and can be hosted on any Windows, Mac or linux computer. You may use the public server hosted by the Next team, or run your own private copy of the server on your PC, or a Raspberry Pi running Raspbian.

A dot command client for the ZX Spectrum Next is written in Z80N assembly language. You may add a command to your AUTOEXEC.BAS file to automatically sync the time every time you boot into NextZXOS. Your Next must be equipped with the RTC (Real Time Clock) in order to make use of *nxtp*.

We also provide a C# reference client using .NET Core 3.0, to assist with porting to other architectures or machines.

## Project Status
*nxtp* is currently in alpha testing. Please check back soon for details of how to use *nxtp* on your ZX Spectrum Next. If you have a GutHub account you can elect to be notified whenever there is a project release.

## Copyright and Licence
*nxtp* is © 2019 Robin Verhagen-Guest, and licensed under [Apache 2.0](LICENSE). 

Everyone is encouraged to host a public *nxtp* server, or port the *nxtp* client to a different machine or architecture.
