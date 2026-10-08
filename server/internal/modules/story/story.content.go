package story

import (
	"bytes"
	"errors"
	"regexp"
	"strings"

	"golang.org/x/net/html"
	"golang.org/x/net/html/atom"
)

var errContentNotFound = errors.New("chapter content element not found")

var blockTags = map[atom.Atom]bool{
	atom.P:          true,
	atom.Div:        true,
	atom.H1:         true,
	atom.H2:         true,
	atom.H3:         true,
	atom.H4:         true,
	atom.H5:         true,
	atom.H6:         true,
	atom.Li:         true,
	atom.Blockquote: true,
	atom.Tr:         true,
}

var skipTags = map[atom.Atom]bool{
	atom.Script:   true,
	atom.Style:    true,
	atom.Ins:      true,
	atom.Iframe:   true,
	atom.Noscript: true,
}

var decorationLine = regexp.MustCompile(`^[\s_\-–—=*.~•·]+$`)

type paragraphCollector struct {
	paragraphs []string
	buffer     strings.Builder
}

func (p *paragraphCollector) flush() {
	text := strings.Join(strings.Fields(p.buffer.String()), " ")
	p.buffer.Reset()
	if text != "" && !decorationLine.MatchString(text) {
		p.paragraphs = append(p.paragraphs, text)
	}
}

func (p *paragraphCollector) walk(node *html.Node) {
	switch node.Type {
	case html.TextNode:
		p.buffer.WriteString(node.Data)
		return
	case html.ElementNode:
		if skipTags[node.DataAtom] {
			return
		}
		if node.DataAtom == atom.Br {
			p.flush()
			return
		}
	}
	block := node.Type == html.ElementNode && blockTags[node.DataAtom]
	if block {
		p.flush()
	}
	for child := node.FirstChild; child != nil; child = child.NextSibling {
		p.walk(child)
	}
	if block {
		p.flush()
	}
}

func paragraphsOf(node *html.Node) []string {
	collector := &paragraphCollector{}
	collector.walk(node)
	collector.flush()
	return collector.paragraphs
}

func findByID(node *html.Node, id string) *html.Node {
	if node.Type == html.ElementNode {
		for _, attr := range node.Attr {
			if attr.Key == "id" && attr.Val == id {
				return node
			}
		}
	}
	for child := node.FirstChild; child != nil; child = child.NextSibling {
		if found := findByID(child, id); found != nil {
			return found
		}
	}
	return nil
}

func pageParagraphs(page []byte, contentID string) ([]string, error) {
	doc, err := html.Parse(bytes.NewReader(page))
	if err != nil {
		return nil, err
	}
	content := findByID(doc, contentID)
	if content == nil {
		return nil, errContentNotFound
	}
	return paragraphsOf(content), nil
}

func fragmentParagraphs(fragment string) ([]string, error) {
	doc, err := html.Parse(strings.NewReader(fragment))
	if err != nil {
		return nil, err
	}
	return paragraphsOf(doc), nil
}

func dropRepeatedTitle(paragraphs []string, title string) []string {
	if len(paragraphs) > 0 && strings.EqualFold(paragraphs[0], strings.Join(strings.Fields(title), " ")) {
		return paragraphs[1:]
	}
	return paragraphs
}
