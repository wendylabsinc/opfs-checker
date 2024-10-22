import './style.css'

function isOPFSSupported() {
  return navigator.storage && navigator.storage.getDirectory;
}

async function getEstimatedMaximumDiskSize() {
  const estimate = await navigator.storage.estimate();
  return estimate.quota;
}

async function getDiskUsage() {
  const estimate = await navigator.storage.estimate();
  return estimate.usage;
}

async function updateDOMWithStorageInfo() {
  const opfsSupport = document.getElementById('opfs-support');
  const estimatedMaximumDiskSize = document.getElementById('estimated-maximum-disk-size');
  const diskUsage = document.getElementById('disk-usage');
  const percentUsed = document.getElementById('percent-used');
  opfsSupport.textContent = isOPFSSupported() ? 'Yes' : 'No';

  try {
    const size = await getEstimatedMaximumDiskSize();
    const sizeInMB = size / 1024 / 1024;
    if (sizeInMB >= 1024) {
      estimatedMaximumDiskSize.textContent = `${(sizeInMB / 1024).toFixed(2)} GB`;
    } else {
      estimatedMaximumDiskSize.textContent = `${sizeInMB.toFixed(2)} MB`;
    }

    const usage = await getDiskUsage();
    diskUsage.textContent = `${(usage / 1024 / 1024).toFixed(2)} MB`;

    const percentUsedCalculated = (usage / size) * 100;
    percentUsed.textContent = `${percentUsedCalculated.toFixed(2)}%`;
  } catch (error) {
    console.error('Error fetching storage information:', error);
  }
}

document.getElementById('browser-agent').textContent = navigator.userAgent;

// Call the async function to update the DOM
updateDOMWithStorageInfo();