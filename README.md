# Windows CodeSign Action
Uses osssigntool to sign windows executable with pfx/p12 keystore and password.
## Inputs

```
  keystore:
    description: "Pfx keystore"
    required: true
  password:
    description: "Pfx keystore password"
    required: false
    default: ""
  appName:
    description: "Application name"
    required: false
    default: ""
  domain:
    description: "Domain"
    required: false
    default: ""
  binaryPath:
    description: "Path to windows binary to be signed"
    required: true
  verify:
    description: "Verify signed binary"
    required: false
    default: "false"
```

## Example

```
- name: Sign Windows Binary
      uses: nodefactoryio/windows-codesign-action@master
         binaryPath: files/app.exe
         verify: "true"
         keystore: ${{ secrets.KEYSTORE }}
         password: ${{ secrets.PASSWORD }}
         appName: 'NodeFactory'
         domain: 'nodefactory.io'
```