# Helm template

Template chart to use for creating universal deployments. This helm template is for personal use only. No guarantees or support will be provided. If you have questions, either open these at issues of repository herewith or send me a private message.

## description

Chart location charts/helm-template. Chart [documentation](helm-template/README.md). 

```bash
make run
git add .
git commit -av
git push origin master
git tag <tag>
git push --tags
```

Push to `master` and add tag.

# ToDo
- [ ] ingress lets encrypt deployment automation
- [ ] cluster issuer deployment automation
- [ ] configurable multiple services

- [x] create registry secrets
- [x] provide a name for configmap
- [x] allow multiple configmaps (for now only one configmap is configured)