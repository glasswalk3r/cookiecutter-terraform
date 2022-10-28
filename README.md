# cookiecutter-tf

Cookiecutter template to manage consistent creation of Terraform modules.

## How to use this template

```bash
$ pip install cookiecutter
$ cookiecutter git@<REPOSITORY>
```

You will be prompted for basic information which will be used in the template.

That's all you need to get started.

It is highly recommended to install `cookiecutter` with a non-root user. For that,
please git a try with [pyenv](https://github.com/pyenv/pyenv-installer):

```bash
$ pyenv install 3.8.0
$ pyenv global 3.8.0
$ pip install --upgrade pip
$ pip install cookiecutter
```

## Attention to the `module_name` information

The given `module_name` input is used to form the path of the AWS backend (in
other words, the path inside the S3 bucket), together with the `resource_type`
input.

Suppose that you want to have a module with this structure:

```
iam/
└── kube2iam
    └── foobar
        └── my_module
```

That will work, but the backend definition will not include the additional path
`kube2iam/foobar/my_module` inside the S3 bucket. Instead, it will use
`iam/my_module`, so if you have multiple `my_module` you will finish rewritten
the state every time you run `terraform`, losing all the previous state.

To fix that, provide a value like a URI, using dots to separate the terms, for
example `kube2iam.foobar.my_module`. Inside the template, on the backend
configuration, those dots will be replaced by a slash and you will end with a
path like `iam/kube2iam/foobar/my_module` inside the S3 bucket. If you mimic
the folder structure you should not run into problems regarding state and the
directory of the module will use the "URI" like name:

```
iam/
└── kube2iam
    └── foobar
        └── kube2iam.foobar.my_module
```

## Additional information

* [Cookiecutter website](https://cookiecutter.readthedocs.io/en/latest/index.html)
* [cookiecutter-tf-module](https://github.com/DualSpark/cookiecutter-tf-module),
which inspired this repository.
