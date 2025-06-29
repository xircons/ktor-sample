@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%"=="" @echo off
@rem ##########################################################################
@rem
@rem  ktor-sample startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%"=="" set DIRNAME=.
@rem This is normally unused
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and KTOR_SAMPLE_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if %ERRORLEVEL% equ 0 goto execute

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\ktor-sample-0.0.1.jar;%APP_HOME%\lib\ktor-server-config-yaml-jvm-3.2.0.jar;%APP_HOME%\lib\ktor-server-content-negotiation-jvm-3.2.0.jar;%APP_HOME%\lib\ktor-server-netty-jvm-3.2.0.jar;%APP_HOME%\lib\ktor-server-core-jvm-3.2.0.jar;%APP_HOME%\lib\ktor-serialization-kotlinx-json-jvm-3.2.0.jar;%APP_HOME%\lib\kotlin-reflect-2.1.21.jar;%APP_HOME%\lib\ktor-http-cio-jvm-3.2.0.jar;%APP_HOME%\lib\ktor-serialization-kotlinx-jvm-3.2.0.jar;%APP_HOME%\lib\ktor-serialization-jvm-3.2.0.jar;%APP_HOME%\lib\ktor-websockets-jvm-3.2.0.jar;%APP_HOME%\lib\ktor-http-jvm-3.2.0.jar;%APP_HOME%\lib\ktor-events-jvm-3.2.0.jar;%APP_HOME%\lib\ktor-network-jvm-3.2.0.jar;%APP_HOME%\lib\ktor-utils-jvm-3.2.0.jar;%APP_HOME%\lib\ktor-io-jvm-3.2.0.jar;%APP_HOME%\lib\kotlinx-coroutines-core-jvm-1.10.2.jar;%APP_HOME%\lib\yamlkt-jvm-0.13.0.jar;%APP_HOME%\lib\kaml-jvm-0.77.1.jar;%APP_HOME%\lib\kotlinx-serialization-core-jvm-1.8.1.jar;%APP_HOME%\lib\kotlinx-serialization-json-io-jvm-1.8.1.jar;%APP_HOME%\lib\kotlinx-serialization-json-jvm-1.8.1.jar;%APP_HOME%\lib\kotlin-stdlib-jdk8-1.8.0.jar;%APP_HOME%\lib\snakeyaml-engine-kmp-jvm-3.1.1.jar;%APP_HOME%\lib\okio-jvm-3.11.0.jar;%APP_HOME%\lib\kotlin-stdlib-jdk7-1.8.0.jar;%APP_HOME%\lib\kotlinx-io-core-jvm-0.7.0.jar;%APP_HOME%\lib\urlencoder-lib-jvm-1.6.0.jar;%APP_HOME%\lib\kotlinx-io-bytestring-jvm-0.7.0.jar;%APP_HOME%\lib\kotlin-stdlib-2.1.21.jar;%APP_HOME%\lib\logback-classic-1.4.14.jar;%APP_HOME%\lib\annotations-23.0.0.jar;%APP_HOME%\lib\logback-core-1.4.14.jar;%APP_HOME%\lib\slf4j-api-2.0.17.jar;%APP_HOME%\lib\config-1.4.3.jar;%APP_HOME%\lib\jansi-2.4.2.jar;%APP_HOME%\lib\netty-codec-http2-4.2.2.Final.jar;%APP_HOME%\lib\alpn-api-1.1.3.v20160715.jar;%APP_HOME%\lib\netty-transport-native-kqueue-4.2.2.Final.jar;%APP_HOME%\lib\netty-transport-native-epoll-4.2.2.Final.jar;%APP_HOME%\lib\netty-codec-http-4.2.2.Final.jar;%APP_HOME%\lib\netty-handler-4.2.2.Final.jar;%APP_HOME%\lib\netty-codec-compression-4.2.2.Final.jar;%APP_HOME%\lib\netty-codec-base-4.2.2.Final.jar;%APP_HOME%\lib\netty-transport-classes-kqueue-4.2.2.Final.jar;%APP_HOME%\lib\netty-transport-classes-epoll-4.2.2.Final.jar;%APP_HOME%\lib\netty-transport-native-unix-common-4.2.2.Final.jar;%APP_HOME%\lib\netty-transport-4.2.2.Final.jar;%APP_HOME%\lib\netty-buffer-4.2.2.Final.jar;%APP_HOME%\lib\netty-resolver-4.2.2.Final.jar;%APP_HOME%\lib\netty-common-4.2.2.Final.jar


@rem Execute ktor-sample
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %KTOR_SAMPLE_OPTS%  -classpath "%CLASSPATH%" io.ktor.server.netty.EngineMain %*

:end
@rem End local scope for the variables with windows NT shell
if %ERRORLEVEL% equ 0 goto mainEnd

:fail
rem Set variable KTOR_SAMPLE_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
set EXIT_CODE=%ERRORLEVEL%
if %EXIT_CODE% equ 0 set EXIT_CODE=1
if not ""=="%KTOR_SAMPLE_EXIT_CONSOLE%" exit %EXIT_CODE%
exit /b %EXIT_CODE%

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
