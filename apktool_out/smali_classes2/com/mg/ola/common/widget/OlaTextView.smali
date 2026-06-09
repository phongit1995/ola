.class public Lcom/mg/ola/common/widget/OlaTextView;
.super Landroid/widget/TextView;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/common/widget/OlaTextView$a;,
        Lcom/mg/ola/common/widget/OlaTextView$b;
    }
.end annotation


# instance fields
.field protected a:Lcom/mg/ola/common/widget/OlaTextView$b;

.field private b:Landroid/view/GestureDetector;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    invoke-direct {p0}, Lcom/mg/ola/common/widget/OlaTextView;->a()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/TextView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    invoke-direct {p0}, Lcom/mg/ola/common/widget/OlaTextView;->a()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/TextView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    invoke-direct {p0}, Lcom/mg/ola/common/widget/OlaTextView;->a()V

    return-void
.end method

.method private a()V
    .locals 4

    :try_start_0
    new-instance v0, Landroid/view/GestureDetector;

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/OlaTextView;->getContext()Landroid/content/Context;

    move-result-object v1

    new-instance v2, Lcom/mg/ola/common/widget/OlaTextView$a;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v3}, Lcom/mg/ola/common/widget/OlaTextView$a;-><init>(Lcom/mg/ola/common/widget/OlaTextView;Lcom/mg/ola/common/widget/OlaTextView$1;)V

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/OlaTextView;->getHandler()Landroid/os/Handler;

    move-result-object v3

    invoke-direct {v0, v1, v2, v3}, Landroid/view/GestureDetector;-><init>(Landroid/content/Context;Landroid/view/GestureDetector$OnGestureListener;Landroid/os/Handler;)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/OlaTextView;->b:Landroid/view/GestureDetector;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic a(Lcom/mg/ola/common/widget/OlaTextView;Landroid/text/style/ClickableSpan;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/OlaTextView;->b(Landroid/text/style/ClickableSpan;)V

    return-void
.end method

.method private a(Landroid/widget/TextView;Ljava/lang/CharSequence;Landroid/view/MotionEvent;)[Landroid/text/style/ClickableSpan;
    .locals 2

    invoke-virtual {p3}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    return-object p1

    :cond_1
    :goto_0
    invoke-virtual {p3}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    float-to-int v0, v0

    invoke-virtual {p3}, Landroid/view/MotionEvent;->getY()F

    move-result p3

    float-to-int p3, p3

    invoke-virtual {p1}, Landroid/widget/TextView;->getTotalPaddingLeft()I

    move-result v1

    sub-int/2addr v0, v1

    invoke-virtual {p1}, Landroid/widget/TextView;->getTotalPaddingTop()I

    move-result v1

    sub-int/2addr p3, v1

    invoke-virtual {p1}, Landroid/widget/TextView;->getScrollX()I

    move-result v1

    add-int/2addr v0, v1

    invoke-virtual {p1}, Landroid/widget/TextView;->getScrollY()I

    move-result v1

    add-int/2addr p3, v1

    invoke-virtual {p1}, Landroid/widget/TextView;->getLayout()Landroid/text/Layout;

    move-result-object p1

    invoke-virtual {p1, p3}, Landroid/text/Layout;->getLineForVertical(I)I

    move-result p3

    int-to-float v0, v0

    invoke-virtual {p1, p3, v0}, Landroid/text/Layout;->getOffsetForHorizontal(IF)I

    move-result p1

    new-instance p3, Landroid/text/SpannableString;

    invoke-direct {p3, p2}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    const-class p2, Landroid/text/style/ClickableSpan;

    invoke-virtual {p3, p1, p1, p2}, Landroid/text/SpannableString;->getSpans(IILjava/lang/Class;)[Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Landroid/text/style/ClickableSpan;

    return-object p1
.end method

.method static synthetic a(Lcom/mg/ola/common/widget/OlaTextView;Landroid/widget/TextView;Ljava/lang/CharSequence;Landroid/view/MotionEvent;)[Landroid/text/style/ClickableSpan;
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/mg/ola/common/widget/OlaTextView;->a(Landroid/widget/TextView;Ljava/lang/CharSequence;Landroid/view/MotionEvent;)[Landroid/text/style/ClickableSpan;

    move-result-object p0

    return-object p0
.end method

.method private b(Landroid/text/style/ClickableSpan;)V
    .locals 4

    iget-object v0, p0, Lcom/mg/ola/common/widget/OlaTextView;->a:Lcom/mg/ola/common/widget/OlaTextView$b;

    if-eqz v0, :cond_5

    :try_start_0
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/OlaTextView;->getText()Ljava/lang/CharSequence;

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
    iget-object v3, p0, Lcom/mg/ola/common/widget/OlaTextView;->a:Lcom/mg/ola/common/widget/OlaTextView$b;

    invoke-interface {v0, v1, v2}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v3, p0, p1, v0}, Lcom/mg/ola/common/widget/OlaTextView$b;->b(Landroid/view/View;Landroid/text/style/ClickableSpan;Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_5
    return-void
.end method


# virtual methods
.method protected a(Landroid/text/style/ClickableSpan;)V
    .locals 4

    iget-object v0, p0, Lcom/mg/ola/common/widget/OlaTextView;->a:Lcom/mg/ola/common/widget/OlaTextView$b;

    if-eqz v0, :cond_5

    :try_start_0
    invoke-virtual {p0}, Lcom/mg/ola/common/widget/OlaTextView;->getText()Ljava/lang/CharSequence;

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
    iget-object v3, p0, Lcom/mg/ola/common/widget/OlaTextView;->a:Lcom/mg/ola/common/widget/OlaTextView$b;

    invoke-interface {v0, v1, v2}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v3, p0, p1, v0}, Lcom/mg/ola/common/widget/OlaTextView$b;->a(Landroid/view/View;Landroid/text/style/ClickableSpan;Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    :cond_5
    invoke-virtual {p1, p0}, Landroid/text/style/ClickableSpan;->onClick(Landroid/view/View;)V

    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/OlaTextView;->b:Landroid/view/GestureDetector;

    invoke-virtual {v0, p1}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    invoke-super {p0, p1}, Landroid/widget/TextView;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method public setOlaSpanClickListener(Lcom/mg/ola/common/widget/OlaTextView$b;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/OlaTextView;->a:Lcom/mg/ola/common/widget/OlaTextView$b;

    return-void
.end method
