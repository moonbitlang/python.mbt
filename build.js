const { execSync } = require('child_process')
const path = require('path')

try {
  // Helper function to execute shell commands and trim output
  const runCommand = (command) => {
    try {
      return execSync(command, { encoding: 'utf8' }).trim()
    } catch (error) {
      console.error(`Error executing command: ${command}`)
      console.error(error.stderr || error.message)
      process.exit(1)
    }
  }

  // 1. Get PY_VERSION
  const pyVersionCmd =
    'python3 -c "import sys; print(f\'{sys.version_info.major}.{sys.version_info.minor}\')"'
  const pyVersion = runCommand(pyVersionCmd)

  // 2. Set CC
  const cc = process.env.CC || 'gcc' // Use environment CC if set, otherwise default to gcc

  // 3. Get Python prefix and include directory
  const pyPrefixCmd = 'python3-config --prefix'
  const pyPrefix = runCommand(pyPrefixCmd)
  const pyIncludeDir = path.join(pyPrefix, 'include', `python${pyVersion}`)

  // 4. Construct CC_FLAGS
  const stubCCFlags = `-I${pyIncludeDir} -DNDEBUG -fsanitize=address -g`
  const ccFlags = stubCCFlags

  // 5. Get Python ldflags
  const pyLdflagsCmd = 'python3-config --ldflags'
  const pyLdflags = runCommand(pyLdflagsCmd)

  // 6. Construct CC_LINK_FLAGS
  // Sometimes ldflags already includes the -lpython part, remove it if present before adding ours
  const baseLdflags = pyLdflags.replace(/-lpython[\d.]+\w*/, '').trim()
  const ccLinkFlags = `${baseLdflags} -lpython${pyVersion} -fsanitize=address -g`

  // 7. Construct C_INCLUDE_PATH
  const existingCIncludePath = process.env.C_INCLUDE_PATH || ''
  const cIncludePath = existingCIncludePath
    ? `${pyIncludeDir}${path.delimiter}${existingCIncludePath}`
    : pyIncludeDir

  // 8. Assemble the variables
  const output = {
    vars: {
      PY_VERSION: pyVersion,
      CC: cc,
      CC_FLAGS: ccFlags,
      STUB_CC_FLAGS: stubCCFlags,
      CC_LINK_FLAGS: ccLinkFlags,
      C_INCLUDE_PATH: cIncludePath,
    },
    link_configs: [
      {
        package: 'Kaida-Amethyst/python/cpython',
        link_flags: ccLinkFlags,
      },
    ],
  }

  console.log(JSON.stringify(output, null, 2))
} catch (error) {
  // Catch any unexpected errors during setup or JSON stringification
  console.error('An unexpected error occurred:', error.message)
  process.exit(1)
}
