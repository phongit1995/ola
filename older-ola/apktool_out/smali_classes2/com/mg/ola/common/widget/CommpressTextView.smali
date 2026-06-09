.class public Lcom/mg/ola/common/widget/CommpressTextView;
.super Lcom/mg/ola/common/widget/OlaTextView;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DrawAllocation"
    }
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/common/widget/CommpressTextView$a;
    }
.end annotation


# instance fields
.field private b:I

.field private c:F

.field private d:F

.field private e:Landroid/text/StaticLayout;

.field private f:Ljava/lang/CharSequence;

.field private g:Ljava/lang/CharSequence;

.field private h:Z

.field private i:Landroid/text/SpannableStringBuilder;

.field private j:Lcom/mg/ola/common/widget/CommpressTextView$a;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/OlaTextView;-><init>(Landroid/content/Context;)V

    const/4 p1, -0x1

    iput p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->b:I

    const/high16 p1, 0x3f800000    # 1.0f

    iput p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->c:F

    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->d:F

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->h:Z

    invoke-direct {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->c()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/mg/ola/common/widget/OlaTextView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, -0x1

    iput p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->b:I

    const/high16 p1, 0x3f800000    # 1.0f

    iput p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->c:F

    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->d:F

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->h:Z

    invoke-direct {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->c()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/mg/ola/common/widget/OlaTextView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, -0x1

    iput p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->b:I

    const/high16 p1, 0x3f800000    # 1.0f

    iput p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->c:F

    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->d:F

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->h:Z

    invoke-direct {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->c()V

    return-void
.end method

.method private c()V
    .locals 5

    :try_start_0
    new-instance v0, Landroid/text/SpannableStringBuilder;

    const-string v1, "\nXem th\u00eam..."

    invoke-direct {v0, v1}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->i:Landroid/text/SpannableStringBuilder;

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->i:Landroid/text/SpannableStringBuilder;

    new-instance v1, Lcom/mg/ola/common/widget/CommpressTextView$1;

    invoke-direct {v1, p0}, Lcom/mg/ola/common/widget/CommpressTextView$1;-><init>(Lcom/mg/ola/common/widget/CommpressTextView;)V

    const/4 v2, 0x0

    iget-object v3, p0, Lcom/mg/ola/common/widget/CommpressTextView;->i:Landroid/text/SpannableStringBuilder;

    invoke-virtual {v3}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v3

    const/16 v4, 0x21

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->h:Z

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->h:Z

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->j:Lcom/mg/ola/common/widget/CommpressTextView$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->j:Lcom/mg/ola/common/widget/CommpressTextView$a;

    const/4 v1, 0x1

    invoke-interface {v0, v1}, Lcom/mg/ola/common/widget/CommpressTextView$a;->a(Z)V

    :cond_0
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->requestLayout()V

    :cond_1
    return-void
.end method

.method protected a(Landroid/text/style/ClickableSpan;)V
    .locals 4

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->a:Lcom/mg/ola/common/widget/OlaTextView$b;

    if-eqz v0, :cond_6

    :try_start_0
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    const/4 v1, 0x0

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    instance-of v3, v0, Landroid/text/Spanned;

    if-eqz v3, :cond_0

    move-object v1, v0

    check-cast v1, Landroid/text/Spanned;

    invoke-interface {v1, p1}, Landroid/text/Spanned;->getSpanStart(Ljava/lang/Object;)I

    move-result v1

    move-object v2, v0

    check-cast v2, Landroid/text/Spanned;

    invoke-interface {v2, p1}, Landroid/text/Spanned;->getSpanEnd(Ljava/lang/Object;)I

    move-result v2

    goto :goto_1

    :cond_0
    instance-of v3, v0, Landroid/text/Spannable;

    if-eqz v3, :cond_1

    move-object v1, v0

    check-cast v1, Landroid/text/Spannable;

    invoke-interface {v1, p1}, Landroid/text/Spannable;->getSpanStart(Ljava/lang/Object;)I

    move-result v1

    move-object v2, v0

    check-cast v2, Landroid/text/Spannable;

    invoke-interface {v2, p1}, Landroid/text/Spannable;->getSpanEnd(Ljava/lang/Object;)I

    move-result v2

    goto :goto_1

    :cond_1
    instance-of v3, v0, Landroid/text/SpannedString;

    if-eqz v3, :cond_2

    move-object v1, v0

    check-cast v1, Landroid/text/SpannedString;

    invoke-virtual {v1, p1}, Landroid/text/SpannedString;->getSpanStart(Ljava/lang/Object;)I

    move-result v1

    move-object v2, v0

    check-cast v2, Landroid/text/SpannedString;

    :goto_0
    invoke-virtual {v2, p1}, Landroid/text/SpannedString;->getSpanEnd(Ljava/lang/Object;)I

    move-result v2

    goto :goto_1

    :cond_2
    instance-of v3, v0, Landroid/text/SpannableString;

    if-eqz v3, :cond_3

    move-object v1, v0

    check-cast v1, Landroid/text/SpannedString;

    invoke-virtual {v1, p1}, Landroid/text/SpannedString;->getSpanStart(Ljava/lang/Object;)I

    move-result v1

    move-object v2, v0

    check-cast v2, Landroid/text/SpannedString;

    goto :goto_0

    :cond_3
    instance-of v3, v0, Landroid/text/SpannableStringBuilder;

    if-eqz v3, :cond_4

    move-object v1, v0

    check-cast v1, Landroid/text/SpannableStringBuilder;

    invoke-virtual {v1, p1}, Landroid/text/SpannableStringBuilder;->getSpanStart(Ljava/lang/Object;)I

    move-result v1

    move-object v2, v0

    check-cast v2, Landroid/text/SpannableStringBuilder;

    invoke-virtual {v2, p1}, Landroid/text/SpannableStringBuilder;->getSpanEnd(Ljava/lang/Object;)I

    move-result v2

    :cond_4
    :goto_1
    invoke-interface {v0, v1, v2}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/mg/ola/common/widget/CommpressTextView;->i:Landroid/text/SpannableStringBuilder;

    invoke-virtual {v2}, Landroid/text/SpannableStringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_5

    invoke-virtual {p1, p0}, Landroid/text/style/ClickableSpan;->onClick(Landroid/view/View;)V

    return-void

    :cond_5
    iget-object v1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->a:Lcom/mg/ola/common/widget/OlaTextView$b;

    invoke-interface {v1, p0, p1, v0}, Lcom/mg/ola/common/widget/OlaTextView$b;->a(Landroid/view/View;Landroid/text/style/ClickableSpan;Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    :cond_6
    invoke-virtual {p1, p0}, Landroid/text/style/ClickableSpan;->onClick(Landroid/view/View;)V

    return-void
.end method

.method public b()V
    .locals 2

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->h:Z

    if-nez v0, :cond_1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->h:Z

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->j:Lcom/mg/ola/common/widget/CommpressTextView$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->j:Lcom/mg/ola/common/widget/CommpressTextView$a;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Lcom/mg/ola/common/widget/CommpressTextView$a;->a(Z)V

    :cond_0
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->requestLayout()V

    :cond_1
    return-void
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1}, Lcom/mg/ola/common/widget/OlaTextView;->onDraw(Landroid/graphics/Canvas;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onMeasure(II)V
    .locals 11

    :try_start_0
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v0

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->getTotalPaddingLeft()I

    move-result v1

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->getTotalPaddingRight()I

    move-result v2

    sub-int/2addr v0, v1

    sub-int/2addr v0, v2

    const/4 v1, 0x0

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v5

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->h:Z

    const v10, 0x7fffffff

    if-eqz v0, :cond_5

    if-lez v5, :cond_5

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->f:Ljava/lang/CharSequence;

    if-eqz v0, :cond_6

    iget v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->b:I

    if-lez v0, :cond_6

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->e:Landroid/text/StaticLayout;

    if-nez v0, :cond_0

    new-instance v0, Landroid/text/StaticLayout;

    iget-object v3, p0, Lcom/mg/ola/common/widget/CommpressTextView;->f:Ljava/lang/CharSequence;

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->getPaint()Landroid/text/TextPaint;

    move-result-object v4

    sget-object v6, Landroid/text/Layout$Alignment;->ALIGN_NORMAL:Landroid/text/Layout$Alignment;

    iget v7, p0, Lcom/mg/ola/common/widget/CommpressTextView;->c:F

    iget v8, p0, Lcom/mg/ola/common/widget/CommpressTextView;->d:F

    const/4 v9, 0x0

    move-object v2, v0

    invoke-direct/range {v2 .. v9}, Landroid/text/StaticLayout;-><init>(Ljava/lang/CharSequence;Landroid/text/TextPaint;ILandroid/text/Layout$Alignment;FFZ)V

    :goto_0
    iput-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->e:Landroid/text/StaticLayout;

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->e:Landroid/text/StaticLayout;

    invoke-virtual {v0}, Landroid/text/StaticLayout;->getWidth()I

    move-result v0

    if-eq v5, v0, :cond_1

    new-instance v0, Landroid/text/StaticLayout;

    iget-object v3, p0, Lcom/mg/ola/common/widget/CommpressTextView;->f:Ljava/lang/CharSequence;

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->getPaint()Landroid/text/TextPaint;

    move-result-object v4

    sget-object v6, Landroid/text/Layout$Alignment;->ALIGN_NORMAL:Landroid/text/Layout$Alignment;

    iget v7, p0, Lcom/mg/ola/common/widget/CommpressTextView;->c:F

    iget v8, p0, Lcom/mg/ola/common/widget/CommpressTextView;->d:F

    const/4 v9, 0x0

    move-object v2, v0

    invoke-direct/range {v2 .. v9}, Landroid/text/StaticLayout;-><init>(Ljava/lang/CharSequence;Landroid/text/TextPaint;ILandroid/text/Layout$Alignment;FFZ)V

    goto :goto_0

    :cond_1
    :goto_1
    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->e:Landroid/text/StaticLayout;

    invoke-virtual {v0}, Landroid/text/StaticLayout;->getLineCount()I

    move-result v0

    iget v2, p0, Lcom/mg/ola/common/widget/CommpressTextView;->b:I

    if-le v0, v2, :cond_4

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->e:Landroid/text/StaticLayout;

    iget v2, p0, Lcom/mg/ola/common/widget/CommpressTextView;->b:I

    invoke-virtual {v0, v2}, Landroid/text/StaticLayout;->getLineStart(I)I

    move-result v0

    iget-object v2, p0, Lcom/mg/ola/common/widget/CommpressTextView;->f:Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-ge v0, v2, :cond_6

    move v2, v0

    :goto_2
    add-int/lit8 v3, v0, -0xa

    if-le v2, v3, :cond_3

    if-ltz v2, :cond_3

    iget-object v3, p0, Lcom/mg/ola/common/widget/CommpressTextView;->f:Ljava/lang/CharSequence;

    invoke-interface {v3, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    const/16 v4, 0x20

    if-ne v3, v4, :cond_2

    move v0, v2

    goto :goto_3

    :cond_2
    add-int/lit8 v2, v2, -0x1

    goto :goto_2

    :cond_3
    :goto_3
    iget-object v2, p0, Lcom/mg/ola/common/widget/CommpressTextView;->f:Ljava/lang/CharSequence;

    invoke-interface {v2, v1, v0}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v0

    iput-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->g:Ljava/lang/CharSequence;

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->g:Ljava/lang/CharSequence;

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/CommpressTextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->i:Landroid/text/SpannableStringBuilder;

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/CommpressTextView;->append(Ljava/lang/CharSequence;)V

    iget v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->b:I

    add-int/lit8 v0, v0, 0x2

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/CommpressTextView;->setMaxLines(I)V

    goto :goto_4

    :cond_4
    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->f:Ljava/lang/CharSequence;

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/CommpressTextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0, v10}, Lcom/mg/ola/common/widget/CommpressTextView;->setMaxLines(I)V

    goto :goto_4

    :cond_5
    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->f:Ljava/lang/CharSequence;

    invoke-virtual {p0, v0}, Lcom/mg/ola/common/widget/CommpressTextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0, v10}, Lcom/mg/ola/common/widget/CommpressTextView;->setMaxLines(I)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->requestLayout()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_6
    :goto_4
    invoke-super {p0, p1, p2}, Lcom/mg/ola/common/widget/OlaTextView;->onMeasure(II)V

    return-void
.end method

.method public setEclipesizeMaxLine(I)V
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->b:I

    if-eq v0, p1, :cond_0

    iput p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->b:I

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->requestLayout()V

    :cond_0
    return-void
.end method

.method public setEllipsize(Landroid/text/TextUtils$TruncateAt;)V
    .locals 0

    return-void
.end method

.method public setFullText(Ljava/lang/CharSequence;)V
    .locals 1

    iput-object p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->f:Ljava/lang/CharSequence;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->g:Ljava/lang/CharSequence;

    iput-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->e:Landroid/text/StaticLayout;

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/CommpressTextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public setLineSpacing(FF)V
    .locals 1

    iput p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->d:F

    iput p2, p0, Lcom/mg/ola/common/widget/CommpressTextView;->c:F

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->e:Landroid/text/StaticLayout;

    invoke-super {p0, p1, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setLineSpacing(FF)V

    return-void
.end method

.method public setMoreText(I)V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/CommpressTextView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/CommpressTextView;->setMoreText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public setMoreText(Ljava/lang/CharSequence;)V
    .locals 4

    if-eqz p1, :cond_0

    new-instance v0, Landroid/text/SpannableStringBuilder;

    const-string v1, "\n"

    invoke-direct {v0, v1}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->i:Landroid/text/SpannableStringBuilder;

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->i:Landroid/text/SpannableStringBuilder;

    invoke-virtual {v0, p1}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    iget-object p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->i:Landroid/text/SpannableStringBuilder;

    new-instance v0, Lcom/mg/ola/common/widget/CommpressTextView$2;

    const/high16 v1, -0x1000000

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Lcom/mg/ola/common/widget/CommpressTextView$2;-><init>(Lcom/mg/ola/common/widget/CommpressTextView;IZ)V

    iget-object v1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->i:Landroid/text/SpannableStringBuilder;

    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v1

    const/16 v3, 0x21

    invoke-virtual {p1, v0, v2, v1, v3}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    :cond_0
    return-void
.end method

.method public setMoreTextColor(I)V
    .locals 4

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->i:Landroid/text/SpannableStringBuilder;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/CommpressTextView;->i:Landroid/text/SpannableStringBuilder;

    new-instance v1, Landroid/text/style/ForegroundColorSpan;

    invoke-direct {v1, p1}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    const/4 p1, 0x0

    iget-object v2, p0, Lcom/mg/ola/common/widget/CommpressTextView;->i:Landroid/text/SpannableStringBuilder;

    invoke-virtual {v2}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v2

    const/16 v3, 0x21

    invoke-virtual {v0, v1, p1, v2, v3}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    :cond_0
    return-void
.end method

.method public setOnEclipesizeListener(Lcom/mg/ola/common/widget/CommpressTextView$a;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/CommpressTextView;->j:Lcom/mg/ola/common/widget/CommpressTextView$a;

    return-void
.end method
