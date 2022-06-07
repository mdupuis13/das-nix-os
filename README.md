# DAS debian OS

Scripts to install a fully functionnal system, from a base os install.

## Prerequisite
Install [curl](https://everything.curl.dev/) to download the raw script related to your OS of choice.

## Structure
<dl>
<dt>install-on_&ltmyos&gt.sh</dt> 
<dd>Script file corresponding to your base OS of choice.</dd>

<dt>Config files</dt> 
<dd>dotfiles contained in a separate repository</dd>

<dt>Environment variables</dt> 
<dd>Some environment variables are needed for the successful completion of the script.</dd>
</dl>


## Config files
Config files are read from a *dotfiles* repo.

Set the DOTFILES_GIT_REPO environment variable set to fetch your own dotfiles, otherwise it fetches my own configs.<br/>
```bash
export DOTFILES_GIT_REPO=<url to your dotfiles repo>
```
This dotfiles repo should be configured to use [GNU Stow](https://www.gnu.org/software/stow/).<br/>

### How to use GNU Stow
[Managing Dotfiles with GNU Stow - Steven R. Baker](https://www.stevenrbaker.com/tech/managing-dotfiles-with-gnu-stow.html)<br/>
[Manage Your Dotfiles Like A Superhero - Jake Wiesler on Youtube](https://youtu.be/FHuwzbpTTo0)



## Development environment
A base development environment can also be setup from a separate repo.
```bash
export DEVENV_GIT_REPO=<url to your dev repo>
```


----

