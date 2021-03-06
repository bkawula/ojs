{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2014-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showGalleyLinks bool Show galley links to users without access?
 *}
{assign var=articlePath value=$article->getBestArticleId($currentJournal)}
{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

<div class="obj_article_summary">
	{if $article->getLocalizedFileName() && $article->getLocalizedShowCoverPage() && !$article->getHideCoverPageToc($locale)}
		<div class="cover">
			<a href="{url page="article" op="view" path=$articlePath}" class="file">
				<img src="{$coverPagePath|escape}{$article->getFileName($locale)|escape}"{if $article->getCoverPageAltText($locale) != ''} alt="{$article->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}>
			</a>
		</div>
	{/if}
	{call_hook name="Templates::Issue::Issue::ArticleCoverImage"}

	<div class="title">
		<a href="{url page="article" op="view" path=$articlePath}">
			{$article->getLocalizedTitle()|strip_unsafe_html}
		</a>
	</div>

	{if $showAuthor || $article->getPages()}
	<div class="meta">
		{if $showAuthor}
		<div class="authors">
			{$article->getAuthorString()}
		</div>
		{/if}

		{* Page numbers for this article *}
		{if $article->getPages()}
			<div class="pages">
				{$article->getPages()|escape}
			</div>
		{/if}
	</div>
	{/if}

	<ul class="galleys_links">
		{if $hasAccess || $showGalleyLinks}
			{foreach from=$article->getGalleys() item=galley}
				<li>
					{assign var="hasArticleAccess" value=$hasAccess}
					{if ($article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN)}
						{assign var="hasArticleAccess" value=1}
					{/if}
					{include file="frontend/objects/galley_link.tpl" parent=$article hasAccess=$hasArticleAccess}
				</li>
			{/foreach}
		{/if}
	</ul>

	{call_hook name="Templates::Issue::Issue::Article"}
</div>
