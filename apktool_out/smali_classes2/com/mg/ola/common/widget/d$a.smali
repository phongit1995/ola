.class Lcom/mg/ola/common/widget/d$a;
.super Landroid/view/GestureDetector$SimpleOnGestureListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/d;


# direct methods
.method private constructor <init>(Lcom/mg/ola/common/widget/d;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    invoke-direct {p0}, Landroid/view/GestureDetector$SimpleOnGestureListener;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mg/ola/common/widget/d;Lcom/mg/ola/common/widget/d$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/d$a;-><init>(Lcom/mg/ola/common/widget/d;)V

    return-void
.end method


# virtual methods
.method public onDown(Landroid/view/MotionEvent;)Z
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    invoke-static {v0}, Lcom/mg/ola/common/widget/d;->a(Lcom/mg/ola/common/widget/d;)Lcom/mg/ola/common/widget/OlaTextView$b;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    iget-object v1, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    iget-object v2, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/d;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v0, v1, v2, p1}, Lcom/mg/ola/common/widget/d;->a(Landroid/widget/TextView;Ljava/lang/CharSequence;Landroid/view/MotionEvent;)[Landroid/text/style/ClickableSpan;

    move-result-object v0

    if-eqz v0, :cond_0

    array-length v0, v0

    if-eqz v0, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    invoke-super {p0, p1}, Landroid/view/GestureDetector$SimpleOnGestureListener;->onDown(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method public onLongPress(Landroid/view/MotionEvent;)V
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/d;->getLinksClickable()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    iget-object v1, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    iget-object v2, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/d;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v0, v1, v2, p1}, Lcom/mg/ola/common/widget/d;->a(Landroid/widget/TextView;Ljava/lang/CharSequence;Landroid/view/MotionEvent;)[Landroid/text/style/ClickableSpan;

    move-result-object v0

    if-eqz v0, :cond_0

    array-length v1, v0

    if-eqz v1, :cond_0

    const/4 p1, 0x0

    aget-object p1, v0, p1

    iget-object v0, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    invoke-static {v0, p1}, Lcom/mg/ola/common/widget/d;->a(Lcom/mg/ola/common/widget/d;Landroid/text/style/ClickableSpan;)V

    return-void

    :cond_0
    invoke-super {p0, p1}, Landroid/view/GestureDetector$SimpleOnGestureListener;->onLongPress(Landroid/view/MotionEvent;)V

    return-void
.end method

.method public onSingleTapUp(Landroid/view/MotionEvent;)Z
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/d;->getLinksClickable()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    iget-object v1, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    iget-object v2, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/d;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v0, v1, v2, p1}, Lcom/mg/ola/common/widget/d;->a(Landroid/widget/TextView;Ljava/lang/CharSequence;Landroid/view/MotionEvent;)[Landroid/text/style/ClickableSpan;

    move-result-object v0

    if-eqz v0, :cond_0

    array-length v1, v0

    if-eqz v1, :cond_0

    const/4 p1, 0x0

    aget-object p1, v0, p1

    iget-object v0, p0, Lcom/mg/ola/common/widget/d$a;->a:Lcom/mg/ola/common/widget/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/d;->a(Landroid/text/style/ClickableSpan;)V

    const/4 p1, 0x1

    return p1

    :cond_0
    invoke-super {p0, p1}, Landroid/view/GestureDetector$SimpleOnGestureListener;->onSingleTapUp(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method
