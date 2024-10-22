import './style.css'

function isOPFSSupported() {
  return 'storage' in navigator && 'getDirectory' in navigator.storage;
}

function getEstimatedMaximumDiskSize() {
  return navigator.storage.estimate().then(estimate => estimate.quota);
}


const opfsSupport = document.getElementById('opfs-support');
const estimatedMaximumDiskSize = document.getElementById('estimated-maximum-disk-size');

opfsSupport.textContent = isOPFSSupported() ? 'Yes' : 'No';
getEstimatedMaximumDiskSize().then(size => {
  const sizeInMB = size / 1024 / 1024;
  if (sizeInMB >= 1024) {
    estimatedMaximumDiskSize.textContent = `${(sizeInMB / 1024).toFixed(2)} GB`;
  } else {
    estimatedMaximumDiskSize.textContent = `${sizeInMB.toFixed(2)} MB`;
  }
});

document.getElementById('browser-agent').textContent = navigator.userAgent;