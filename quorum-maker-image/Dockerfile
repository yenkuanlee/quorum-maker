FROM denny60004/ubuntu
ENV DEBIAN_FRONTEND noninteractive
ADD lib/install_baseimage.sh /root/quorum-maker/install_baseimage.sh
RUN /root/quorum-maker/install_baseimage.sh

ADD bin/geth /usr/local/bin
ADD bin/bootnode /usr/local/bin
ADD bin/crux /usr/local/bin
ADD bin/quorum-maker-nodemanager /root/quorum-maker/NodeManager
ADD bin/dist /root/quorum-maker/NodeManagerUI

# ADD quorum-maker-nodemanager/quorum-maker-nodemanager /root/quorum-maker/NodeManager
# ADD quorum-maker-ui/webApp/dist /root/quorum-maker/NodeManagerUI

ADD lib/start_nodemanager.sh /root/quorum-maker/start_nodemanager.sh
RUN chmod +x /root/quorum-maker/start_nodemanager.sh

ADD lib/reset_chain.sh /root/quorum-maker/reset_chain.sh
RUN chmod +x /root/quorum-maker/reset_chain.sh

ADD quorum-maker-nodemanager/NetworkManagerContract.sol /root/quorum-maker/NetworkManagerContract.sol
ADD quorum-maker-nodemanager/NodeUnavailableTemplate.txt /root/quorum-maker/NodeUnavailableTemplate.txt
ADD quorum-maker-nodemanager/JoinRequestTemplate.txt /root/quorum-maker/JoinRequestTemplate.txt
ADD quorum-maker-nodemanager/TestMailTemplate.txt /root/quorum-maker/TestMailTemplate.txt
ADD quorum-maker-nodemanager/nmcBytecode /root/quorum-maker/nmcBytecode
