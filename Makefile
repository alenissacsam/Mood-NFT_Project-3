include .env

.PHONY: deploy deploy-nexus mint flip

deploy:
	@echo "Deploying BasicNft contract..."
	@forge script script/DeployMoodNft.s.sol:DeployMoodNft --rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) --broadcast 
	@echo "Deployment complete."

deploy-nexus:
	@echo "Deploying BasicNft contract..."
	@forge script script/DeployMoodNft.s.sol:DeployMoodNft --rpc-url $(NEXUS_RPC_URL) \
	--private-key $(PRIVATE_KEY_NEXUS) --broadcast --verify \
	--verifier blockscout --verifier-url 'https://testnet3.explorer.nexus.xyz/api/' -vv
	@echo "Deployment complete."	

mint:
	@echo "Minting NFT..."
	@forge script script/interaction.s.sol:MintMoodNft --rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) --broadcast
	@echo "Minting complete."

flip:
	@echo "Flipping mood..."
	@forge script script/interaction.s.sol:FlipMoodNft --rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) --broadcast
	@echo "Mood flipped."