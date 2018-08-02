<%--
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/render/init.jsp" %>

<%
CPContentHelper cpContentHelper = (CPContentHelper)request.getAttribute(CPContentWebKeys.CP_CONTENT_HELPER);

CPCatalogEntry cpCatalogEntry = cpContentHelper.getCPCatalogEntry(request);
CPSku cpSku = cpContentHelper.getDefaultCPSku(cpCatalogEntry);

long cpDefinitionId = cpCatalogEntry.getCPDefinitionId();
String brandName = "";
%>

<div class="container-fluid container-fluid-max-xl">
	<div class="product-detail" id="<portlet:namespace /><%= cpDefinitionId %>ProductContent">
		<div class="commerce-component-header product-detail-header">
			<h2 class="component-title"><%= cpCatalogEntry.getName() %></h2>
			<div class="autofit-float autofit-padded-no-gutters autofit-row autofit-row-center product-detail-subheader">
				<c:if test="<%= brandName != null %>">
					<div class="autofit-col">
						<div class="commerce-brand-name"> <%= brandName %></div>
					</div>
				</c:if>

				<div class="autofit-col">
					<div class="commerce-model-number">
					<span class='<%= (cpSku == null) ? "hide" : StringPool.BLANK %>' data-text-cp-instance-manufacturer-part-number-show><%= LanguageUtil.format(request, "manufacturer-part-number-x", StringPool.BLANK) %></span>
					<span data-text-cp-instance-manufacturer-part-number><%= (cpSku == null) ? StringPool.BLANK : cpSku.getManufacturerPartNumber() %></span>
					</div>
				</div>

				<div class="autofit-col">
					<div class="commerce-sku">
										<span class='<%= (cpSku == null) ? "hide" : StringPool.BLANK %>' data-text-cp-instance-sku-show><%= LanguageUtil.format(request, "sku-x", StringPool.BLANK) %></span>
										<span data-text-cp-instance-sku><%= (cpSku == null) ? StringPool.BLANK : cpSku.getSku() %></span>
					</div>
				</div>
			</div>
		</div>

		<div class="product-detail-body">
			<div class="product-detail-image-widget-column">
				<div class="product-detail-image-widget">
					<div class="product-detail-thumbnail-column">

									<%
					List<CPAttachmentFileEntry> imagesCPAttachmentFileEntries = cpContentHelper.getImages(cpDefinitionId);

					String[] imageOverflowUrls = new String[imagesCPAttachmentFileEntries.size()];

					for (int i = 0; i < imagesCPAttachmentFileEntries.size(); i++) {
						CPAttachmentFileEntry cpAttachmentFileEntry = imagesCPAttachmentFileEntries.get(i);

						String url = cpContentHelper.getImageURL(cpAttachmentFileEntry.getFileEntry(), themeDisplay);

						imageOverflowUrls = ArrayUtil.append(imageOverflowUrls, url);
					%>

											<c:choose>
							<c:when test="<%= i > 3 %>">
								<c:if test="<%= i == 4 %>">
									<div class="product-detail-thumbnail-container product-detail-thumbnail-text-container" id="<portlet:namespace />thumbs-container">
										<a class="thumb thumb-text" data-toggle="modal" href="#<portlet:namespace />ImageWidgetModal">
											+ <%= imagesCPAttachmentFileEntries.size() - i %>
										</a>
									</div>
								</c:if>
							</c:when>
							<c:otherwise>
								<div class="product-detail-thumbnail-container" id="<portlet:namespace />thumbs-container">
									<a class="thumb thumb-image" data-standard="<%= url %>" href="<%= url %>">
										<img class="img-fluid" src="<%= url %>">
									</a>
								</div>
							</c:otherwise>
						</c:choose>

					<%
					}
					%>

					</div>

				<c:if test="<%= Validator.isNotNull(cpCatalogEntry.getDefaultImageFileUrl()) %>">
					<div class="product-detail-image-column">
						<div class="full-image product-detail-image-container">
							<div class="easyzoom easyzoom--adjacent product-detail-image">
								<a href="<%= cpCatalogEntry.getDefaultImageFileUrl() %>" tabindex="-1">
									<img class="img-fluid" id="<portlet:namespace />full-image" src="<%= cpCatalogEntry.getDefaultImageFileUrl() %>">
								</a>
							</div>
						</div>
					</div>
				</c:if>
				</div>

				<div class="product-detail-social-navigation">
					<ul class="nav">
						<li class="nav-item">
							<a href="#1">
																<aui:icon image="social-facebook" markupView="lexicon" />
							</a>
						</li>
						<li class="nav-item">
							<a href="#1">
																<aui:icon image="twitter" markupView="lexicon" />
							</a>
						</li>
						<li class="nav-item">
							<a href="#1">
																<aui:icon image="social-linkedin" markupView="lexicon" />
							</a>
						</li>
						<li class="nav-item">
							<a href="#1">
								<span class="icon-instagram"></span>
							</a>
						</li>
						<li class="nav-item">
							<a href="#1">
								<span class="icon-youtube-play"></span>
							</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="product-detail-info">
				<div class="autofit-float autofit-row product-detail-info-header">
					<div class="autofit-col autofit-col-expand">
						<h2 class="commerce-price" data-text-cp-instance-price><c:if test="<%= cpSku != null %>">
							<liferay-commerce:price CPDefinitionId="<%= cpDefinitionId %>" CPInstanceId="<%= cpSku.getCPInstanceId() %>" />
						</c:if>
												</h2>
					</div>

					<c:if test="<%= cpSku != null %>">
					<div class="autofit-col autofit-col-expand">
						<div class="autofit-section">
							<strong data-text-cp-instance-price>
								<liferay-commerce:price
									CPDefinitionId="<%= cpDefinitionId %>"
									CPInstanceId="<%= cpSku.getCPInstanceId() %>"
								/>
							</strong>
						</div>
					</div>
										</c:if>

					<c:if test="<%= cpSku != null %>">
						<div class="autofit-col autofit-col-expand">
							<div class="autofit-section">
								<strong>You save <span data-text-placeholder>0%</span></strong>
							</div>
						</div>
					</c:if>

					<c:if test="<%= cpSku != null %>">
						<div class="autofit-col">
							<div class="autofit-section">
								<a href="#placeholder">
									more discount info
																		<aui:icon image="info-circle" markupView="lexicon" />
								</a>
							</div>
						</div>
					</c:if>
				</div>

				<c:if test="<%= cpContentHelper.renderOptions(renderRequest, renderResponse) != null %>">
					<div class="product-detail-options">
						<%= cpContentHelper.renderOptions(renderRequest, renderResponse) %>
					</div>
				</c:if>

				<c:if test="<%= cpSku != null %>">
					<liferay-commerce:tier-price
					CPInstanceId="<%= cpSku.getCPInstanceId() %>"
					taglibQuantityInputId='<%= renderResponse.getNamespace() + cpDefinitionId + "Quantity" %>'
				/>
				</c:if>

				<div class="product-detail-info-selections">
					<div class="autofit-float autofit-padded-no-gutters autofit-row autofit-row-center">
						<div class="autofit-col commerce-quantity-input">
							<liferay-commerce:quantity-input
						CPDefinitionId="<%= cpDefinitionId %>"
						useSelect="<%= false %>"

							/>
						</div>

						<div class="autofit-col">
							<liferay-commerce-cart:add-to-cart
						CPDefinitionId="<%= cpDefinitionId %>"
						CPInstanceId="<%= (cpSku == null) ? 0 : cpSku.getCPInstanceId() %>"
						elementClasses="btn-primary text-truncate"
						productContentId='<%= renderResponse.getNamespace() + cpDefinitionId + "ProductContent" %>'
						taglibQuantityInputId='<%= renderResponse.getNamespace() + cpDefinitionId + "Quantity" %>'
					/>
						</div>

						<div class="autofit-col autofit-col-expand">
							<div class="autofit-section">
								<#-- discount % and $ saved goes here -->

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<c:if test="<%= !ArrayUtil.isEmpty(imageOverflowUrls) %>">
			<div aria-hidden="true" aria-labelledby="" class="fade modal modal-hidden product-detail-image-widget-modal" id="<portlet:namespace />ImageWidgetModal" role="dialog" tabindex="-1">
				<div class="modal-dialog modal-full-screen" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<div class="modal-title"><%= cpCatalogEntry.getName() %></div>
							<button aria-label="Close" class="close" data-dismiss="modal" type="button">
								<aui:icon image="times" markupView="lexicon" />
							</button>
						</div>

						<div class="modal-body">
							<div class="carousel" data-interval="false" data-ride="carousel" id="carouselExampleFade">
								<div class="carousel-inner">

									<%
									for (int i = 0; i > imageOverflowUrls.length; i++) {
										String url = imageOverflowUrls[i];

										String carouselItemCssClass = "carousel-item";

										if ((imageOverflowUrls.length > 3) && url.equals(imageOverflowUrls[3])) {
											carouselItemCssClass += " active";
										}
									%>

										<div class="<%= carouselItemCssClass %>">
											<div class="carousel-item-image">
												<img alt="Product Image" class="img-fluid" src="<%= url %>">
											</div>

											<div class="carousel-index"><%= i %>/<%= imageOverflowUrls.length %></div>
										</div>

									<%
									}
									%>

									<a class="carousel-control-prev" data-slide="prev" href="#carouselExampleFade" role="button">
										<aui:icon image="angle-left" markupView="lexicon" />

										<span class="sr-only">Previous</span>
									</a>

									<a class="carousel-control-next" data-slide="next" href="#carouselExampleFade" role="button">
										<aui:icon image="angle-right" markupView="lexicon" />

										<span class="sr-only">Next</span>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:if>
	</div>
</div>

	<%
	List<CPDefinitionSpecificationOptionValue> cpDefinitionSpecificationOptionValues = cpContentHelper.getCPDefinitionSpecificationOptionValues(cpDefinitionId);
	List<CPOptionCategory> cpOptionCategories = cpContentHelper.getCPOptionCategories(scopeGroupId);
	List<CPAttachmentFileEntry> cpAttachmentFileEntries = cpContentHelper.getCPAttachmentFileEntries(cpDefinitionId);
	%>

	<div class="product-detail-description">
		<div class="container-fluid container-fluid-max-xl">
			<ul class="nav nav-underline product-detail-description-tabs" role="tablist">
				<c:if test="<%= Validator.isNotNull(cpCatalogEntry.getDescription()) %>">
					<li class="nav-item" role="presentation">
						<a aria-controls="<portlet:namespace />description" aria-expanded="true" class="active nav-link" data-toggle="tab" href="#<portlet:namespace />description" role="tab">
							<%= LanguageUtil.get(resourceBundle, "description") %>
						</a>
					</li>
				</c:if>

				<c:if test="<%= cpContentHelper.hasCPDefinitionSpecificationOptionValues(cpDefinitionId) %>">
					<li class="nav-item" role="presentation">
					<a aria-controls="<portlet:namespace />specification" aria-expanded="false" class="nav-link" data-toggle="tab" href="#<portlet:namespace />specification" role="tab">
						<%= LanguageUtil.get(resourceBundle, "specifications") %>
					</a>
										</li>
				</c:if>

				<c:if test="<%= !cpAttachmentFileEntries.isEmpty() %>">
					<li class="nav-item" role="presentation">
					<a aria-controls="<portlet:namespace />attachments" aria-expanded="false" class="nav-link" data-toggle="tab" href="#<portlet:namespace />attachments" role="tab">
						<%= LanguageUtil.get(resourceBundle, "attachments") %>
					</a>
				</li>
								</c:if>
			</ul>

			<div class="tab-content">
				<c:if test="<%= Validator.isNotNull(cpCatalogEntry.getDescription()) %>">
				<div class="active fade show tab-pane" id="<portlet:namespace />description">
					<p><%= cpCatalogEntry.getDescription() %></p>
				</div>
								</c:if>

				<c:if test="<%= cpContentHelper.hasCPDefinitionSpecificationOptionValues(cpDefinitionId) %>">
					<div class="fade tab-pane" id="<portlet:namespace />specifications">
						<c:if test="<%= !cpDefinitionSpecificationOptionValues.isEmpty() %>">
							<dl class="autofit-float autofit-row autofit-row-center specification-list">

									<%
										for (CPDefinitionSpecificationOptionValue cpDefinitionSpecificationOptionValue : cpDefinitionSpecificationOptionValues) {
											CPSpecificationOption cpSpecificationOption = cpDefinitionSpecificationOptionValue.getCPSpecificationOption();
										%>

									<dt class="autofit-col specification-term">
										<%= cpSpecificationOption.getTitle(languageId) %>
									</dt>
									<dd class="autofit-col specification-desc">
										<%= cpDefinitionSpecificationOptionValue.getValue(languageId) %>
									</dd>

									<%
									}
									%>

							</dl>
						</c:if>

						<%
					for (CPOptionCategory cpOptionCategory : cpOptionCategories) {
						List<CPDefinitionSpecificationOptionValue> categorizedCPDefinitionSpecificationOptionValues = cpContentHelper.getCategorizedCPDefinitionSpecificationOptionValues(cpDefinitionId, cpOptionCategory.getCPOptionCategoryId());
					%>

						<c:if test="<%= !categorizedCPDefinitionSpecificationOptionValues.isEmpty() %>">
								<dl class="autofit-float autofit-row autofit-row-center specification-list">

									<%
									for (CPDefinitionSpecificationOptionValue cpDefinitionSpecificationOptionValue : categorizedCPDefinitionSpecificationOptionValues) {
										CPSpecificationOption cpSpecificationOption = cpDefinitionSpecificationOptionValue.getCPSpecificationOption();
									%>

										<dt class="autofit-col specification-term">
											<%= cpSpecificationOption.getTitle(languageId) %>
										</dt>
										<dd class="autofit-col specification-desc">
											<%= cpDefinitionSpecificationOptionValue.getValue(languageId) %>
										</dd>

									<%
									}
									%>

								</dl>
							</c:if>

						<%
												}
												%>

					</div>
				</c:if>

				<c:if test="<%= !cpAttachmentFileEntries.isEmpty() %>">
					<div class="fade tab-pane" id="<portlet:namespace />attachments">
						<dl class="autofit-float autofit-row autofit-row-center specification-list">

							<%
							int attachmentsCount = 0;

							for (CPAttachmentFileEntry curCPAttachmentFileEntry : cpAttachmentFileEntries) {
								FileEntry fileEntry = curCPAttachmentFileEntry.getFileEntry();
							%>

								<dt class="autofit-col specification-term">
									<%= curCPAttachmentFileEntry.getTitle(themeDisplay.getLanguageId()) %>
								</dt>
								<dd class="autofit-col specification-desc">
									<aui:icon cssClass="icon-monospaced" image="download" markupView="lexicon" url="<%= cpContentHelper.getDownloadFileEntryURL(fileEntry, themeDisplay) %>" />
								</dd>

								<%
								attachmentsCount = attachmentsCount + 1;

								if (attachmentsCount >= 2) {
								%>

										<dt class="autofit-col specification-empty specification-term"></dt>
										<dd class="autofit-col specification-desc specification-empty"></dd>

									<%
									attachmentsCount = 0;
								}
								%>

							<%
							}
							%>

						</dl>
					</div>
				</c:if>
			</div>
		</div>
	</div>

<aui:script use="liferay-commerce-product-content">
	var productContent = new Liferay.Portlet.ProductContent(
		{
			cpDefinitionId: <%= cpDefinitionId %>,
			fullImageSelector : '#<portlet:namespace />full-image',
			namespace: '<portlet:namespace />',
			productContentSelector: '#<portlet:namespace /><%= cpDefinitionId %>ProductContent',
			thumbsContainerSelector : '#<portlet:namespace />thumbs-container',
			viewAttachmentURL: '<%= String.valueOf(cpContentHelper.getViewAttachmentURL(liferayPortletRequest, liferayPortletResponse)) %>'
		}
	);

	Liferay.component('<portlet:namespace /><%= cpDefinitionId %>ProductContent', productContent);
</aui:script>