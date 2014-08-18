<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="xbr" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="GSM_RX" />
        <signal name="GSM_LD_TX" />
        <signal name="GSM_DSR" />
        <signal name="GSM_CTS" />
        <signal name="GSM_RING" />
        <signal name="GSM_DCD" />
        <signal name="GSM_LD_DTR" />
        <signal name="GSM_LD_RTS" />
        <signal name="GPS_TX" />
        <signal name="GPS_LD_RX" />
        <signal name="MODE(1:0)" />
        <signal name="TRACE_TX" />
        <signal name="TRACE_LD_RX" />
        <signal name="SERVICE_IN" />
        <signal name="SERVICE_OUT" />
        <signal name="TRACE_RX" />
        <signal name="TRACE_LD_TX" />
        <signal name="GPS_LD_TX" />
        <signal name="GPS_RX" />
        <signal name="GSM_RTS" />
        <signal name="GSM_DTR" />
        <signal name="GSM_LD_DCD" />
        <signal name="GSM_LD_RING" />
        <signal name="GSM_LD_CTS" />
        <signal name="GSM_LD_DSR" />
        <signal name="GSM_TX" />
        <signal name="GSM_LD_RX" />
        <signal name="FORCEON_LD1" />
        <signal name="FORCEON_LD0" />
        <signal name="nFORCEOFF_LD1" />
        <signal name="nFORCEOFF_LD0" />
        <port polarity="Input" name="GSM_RX" />
        <port polarity="Input" name="GSM_LD_TX" />
        <port polarity="Input" name="GSM_DSR" />
        <port polarity="Input" name="GSM_CTS" />
        <port polarity="Input" name="GSM_RING" />
        <port polarity="Input" name="GSM_DCD" />
        <port polarity="Input" name="GSM_LD_DTR" />
        <port polarity="Input" name="GSM_LD_RTS" />
        <port polarity="Input" name="GPS_TX" />
        <port polarity="Input" name="GPS_LD_RX" />
        <port polarity="Input" name="MODE(1:0)" />
        <port polarity="Input" name="TRACE_TX" />
        <port polarity="Input" name="TRACE_LD_RX" />
        <port polarity="Input" name="SERVICE_IN" />
        <port polarity="Output" name="SERVICE_OUT" />
        <port polarity="Output" name="TRACE_RX" />
        <port polarity="Output" name="TRACE_LD_TX" />
        <port polarity="Output" name="GPS_LD_TX" />
        <port polarity="Output" name="GPS_RX" />
        <port polarity="Output" name="GSM_RTS" />
        <port polarity="Output" name="GSM_DTR" />
        <port polarity="Output" name="GSM_LD_DCD" />
        <port polarity="Output" name="GSM_LD_RING" />
        <port polarity="Output" name="GSM_LD_CTS" />
        <port polarity="Output" name="GSM_LD_DSR" />
        <port polarity="Output" name="GSM_TX" />
        <port polarity="Output" name="GSM_LD_RX" />
        <port polarity="Output" name="FORCEON_LD1" />
        <port polarity="Output" name="FORCEON_LD0" />
        <port polarity="Output" name="nFORCEOFF_LD1" />
        <port polarity="Output" name="nFORCEOFF_LD0" />
        <blockdef name="ModeSelect">
            <timestamp>2010-4-12T19:25:16</timestamp>
            <line x2="0" y1="1888" y2="1888" x1="64" />
            <line x2="496" y1="1888" y2="1888" x1="432" />
            <line x2="0" y1="1760" y2="1760" x1="64" />
            <line x2="0" y1="1824" y2="1824" x1="64" />
            <line x2="496" y1="1760" y2="1760" x1="432" />
            <rect width="64" x="0" y="1684" height="24" />
            <line x2="0" y1="1696" y2="1696" x1="64" />
            <line x2="0" y1="928" y2="928" x1="64" />
            <line x2="0" y1="992" y2="992" x1="64" />
            <line x2="0" y1="1056" y2="1056" x1="64" />
            <line x2="0" y1="1120" y2="1120" x1="64" />
            <line x2="0" y1="1184" y2="1184" x1="64" />
            <line x2="0" y1="1248" y2="1248" x1="64" />
            <line x2="0" y1="1312" y2="1312" x1="64" />
            <line x2="0" y1="1376" y2="1376" x1="64" />
            <line x2="0" y1="1440" y2="1440" x1="64" />
            <line x2="0" y1="1504" y2="1504" x1="64" />
            <line x2="496" y1="928" y2="928" x1="432" />
            <line x2="496" y1="992" y2="992" x1="432" />
            <line x2="496" y1="1056" y2="1056" x1="432" />
            <line x2="496" y1="1120" y2="1120" x1="432" />
            <line x2="496" y1="1184" y2="1184" x1="432" />
            <line x2="496" y1="1248" y2="1248" x1="432" />
            <line x2="496" y1="1312" y2="1312" x1="432" />
            <line x2="496" y1="1376" y2="1376" x1="432" />
            <line x2="496" y1="1440" y2="1440" x1="432" />
            <line x2="496" y1="1504" y2="1504" x1="432" />
            <line x2="496" y1="1632" y2="1632" x1="432" />
            <line x2="496" y1="-224" y2="-224" x1="432" />
            <line x2="496" y1="-160" y2="-160" x1="432" />
            <line x2="496" y1="-96" y2="-96" x1="432" />
            <line x2="496" y1="-32" y2="-32" x1="432" />
            <rect width="368" x="64" y="-896" height="2816" />
        </blockdef>
        <block symbolname="ModeSelect" name="Mode_Sel">
            <blockpin signalname="GSM_RX" name="GSM_RX" />
            <blockpin signalname="GSM_LD_TX" name="GSM_LD_TX" />
            <blockpin signalname="GSM_DSR" name="GSM_DSR" />
            <blockpin signalname="GSM_CTS" name="GSM_CTS" />
            <blockpin signalname="GSM_RING" name="GSM_RING" />
            <blockpin signalname="GSM_DCD" name="GSM_DCD" />
            <blockpin signalname="GSM_LD_DTR" name="GSM_LD_DTR" />
            <blockpin signalname="GSM_LD_RTS" name="GSM_LD_RTS" />
            <blockpin signalname="GPS_TX" name="GPS_TX" />
            <blockpin signalname="GPS_LD_RX" name="GPS_LD_RX" />
            <blockpin signalname="TRACE_TX" name="TRACE_TX" />
            <blockpin signalname="TRACE_LD_RX" name="TRACE_LD_RX" />
            <blockpin signalname="MODE(1:0)" name="MODE(1:0)" />
            <blockpin signalname="GSM_LD_RX" name="GSM_LD_RX" />
            <blockpin signalname="GSM_TX" name="GSM_TX" />
            <blockpin signalname="GSM_LD_DSR" name="GSM_LD_DSR" />
            <blockpin signalname="GSM_LD_CTS" name="GSM_LD_CTS" />
            <blockpin signalname="GSM_LD_RING" name="GSM_LD_RING" />
            <blockpin signalname="GSM_LD_DCD" name="GSM_LD_DCD" />
            <blockpin signalname="GSM_DTR" name="GSM_DTR" />
            <blockpin signalname="GSM_RTS" name="GSM_RTS" />
            <blockpin signalname="GPS_RX" name="GPS_RX" />
            <blockpin signalname="GPS_LD_TX" name="GPS_LD_TX" />
            <blockpin signalname="TRACE_RX" name="TRACE_RX" />
            <blockpin signalname="TRACE_LD_TX" name="TRACE_LD_TX" />
            <blockpin signalname="nFORCEOFF_LD0" name="nFORCEOFF_LD0" />
            <blockpin signalname="nFORCEOFF_LD1" name="nFORCEOFF_LD1" />
            <blockpin signalname="FORCEON_LD0" name="FORCEON_LD0" />
            <blockpin signalname="FORCEON_LD1" name="FORCEON_LD1" />
            <blockpin signalname="SERVICE_IN" name="SERVICE_IN" />
            <blockpin signalname="SERVICE_OUT" name="SERVICE_OUT" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="5440" height="3520">
        <instance x="2032" y="1104" name="Mode_Sel" orien="R0">
        </instance>
        <branch name="GSM_RX">
            <wire x2="2032" y1="2032" y2="2032" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2032" name="GSM_RX" orien="R180" />
        <branch name="GSM_LD_TX">
            <wire x2="2032" y1="2096" y2="2096" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2096" name="GSM_LD_TX" orien="R180" />
        <branch name="GSM_DSR">
            <wire x2="2032" y1="2160" y2="2160" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2160" name="GSM_DSR" orien="R180" />
        <branch name="GSM_CTS">
            <wire x2="2032" y1="2224" y2="2224" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2224" name="GSM_CTS" orien="R180" />
        <branch name="GSM_RING">
            <wire x2="2032" y1="2288" y2="2288" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2288" name="GSM_RING" orien="R180" />
        <branch name="GSM_DCD">
            <wire x2="2032" y1="2352" y2="2352" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2352" name="GSM_DCD" orien="R180" />
        <branch name="GSM_LD_DTR">
            <wire x2="2032" y1="2416" y2="2416" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2416" name="GSM_LD_DTR" orien="R180" />
        <branch name="GSM_LD_RTS">
            <wire x2="2032" y1="2480" y2="2480" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2480" name="GSM_LD_RTS" orien="R180" />
        <branch name="GPS_TX">
            <wire x2="2032" y1="2544" y2="2544" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2544" name="GPS_TX" orien="R180" />
        <branch name="GPS_LD_RX">
            <wire x2="2032" y1="2608" y2="2608" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2608" name="GPS_LD_RX" orien="R180" />
        <branch name="MODE(1:0)">
            <wire x2="2032" y1="2800" y2="2800" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2800" name="MODE(1:0)" orien="R180" />
        <branch name="TRACE_TX">
            <wire x2="2032" y1="2864" y2="2864" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2864" name="TRACE_TX" orien="R180" />
        <branch name="TRACE_LD_RX">
            <wire x2="2032" y1="2928" y2="2928" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2928" name="TRACE_LD_RX" orien="R180" />
        <branch name="SERVICE_IN">
            <wire x2="2032" y1="2992" y2="2992" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2000" y="2992" name="SERVICE_IN" orien="R180" />
        <branch name="SERVICE_OUT">
            <wire x2="2560" y1="2992" y2="2992" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2992" name="SERVICE_OUT" orien="R0" />
        <branch name="TRACE_RX">
            <wire x2="2560" y1="2864" y2="2864" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2864" name="TRACE_RX" orien="R0" />
        <branch name="TRACE_LD_TX">
            <wire x2="2560" y1="2736" y2="2736" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2736" name="TRACE_LD_TX" orien="R0" />
        <branch name="GPS_LD_TX">
            <wire x2="2560" y1="2608" y2="2608" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2608" name="GPS_LD_TX" orien="R0" />
        <branch name="GPS_RX">
            <wire x2="2560" y1="2544" y2="2544" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2544" name="GPS_RX" orien="R0" />
        <branch name="GSM_RTS">
            <wire x2="2560" y1="2480" y2="2480" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2480" name="GSM_RTS" orien="R0" />
        <branch name="GSM_DTR">
            <wire x2="2560" y1="2416" y2="2416" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2416" name="GSM_DTR" orien="R0" />
        <branch name="GSM_LD_DCD">
            <wire x2="2560" y1="2352" y2="2352" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2352" name="GSM_LD_DCD" orien="R0" />
        <branch name="GSM_LD_RING">
            <wire x2="2560" y1="2288" y2="2288" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2288" name="GSM_LD_RING" orien="R0" />
        <branch name="GSM_LD_CTS">
            <wire x2="2560" y1="2224" y2="2224" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2224" name="GSM_LD_CTS" orien="R0" />
        <branch name="GSM_LD_DSR">
            <wire x2="2560" y1="2160" y2="2160" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2160" name="GSM_LD_DSR" orien="R0" />
        <branch name="GSM_TX">
            <wire x2="2560" y1="2096" y2="2096" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2096" name="GSM_TX" orien="R0" />
        <branch name="GSM_LD_RX">
            <wire x2="2560" y1="2032" y2="2032" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="2032" name="GSM_LD_RX" orien="R0" />
        <branch name="FORCEON_LD1">
            <wire x2="2560" y1="1072" y2="1072" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="1072" name="FORCEON_LD1" orien="R0" />
        <branch name="FORCEON_LD0">
            <wire x2="2560" y1="1008" y2="1008" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="1008" name="FORCEON_LD0" orien="R0" />
        <branch name="nFORCEOFF_LD1">
            <wire x2="2560" y1="944" y2="944" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="944" name="nFORCEOFF_LD1" orien="R0" />
        <branch name="nFORCEOFF_LD0">
            <wire x2="2560" y1="880" y2="880" x1="2528" />
        </branch>
        <iomarker fontsize="28" x="2560" y="880" name="nFORCEOFF_LD0" orien="R0" />
    </sheet>
</drawing>