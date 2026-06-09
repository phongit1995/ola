.class public Lcom/mg/ola/common/d/a/a;
.super Landroid/text/style/ClickableSpan;


# instance fields
.field private a:I

.field private b:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/text/style/ClickableSpan;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/common/d/a/a;->b:Z

    return-void
.end method

.method public constructor <init>(IZ)V
    .locals 1

    invoke-direct {p0}, Landroid/text/style/ClickableSpan;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/common/d/a/a;->b:Z

    iput p1, p0, Lcom/mg/ola/common/d/a/a;->a:I

    iput-boolean p2, p0, Lcom/mg/ola/common/d/a/a;->b:Z

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    return-void
.end method

.method public updateDrawState(Landroid/text/TextPaint;)V
    .locals 1

    iget v0, p0, Lcom/mg/ola/common/d/a/a;->a:I

    if-nez v0, :cond_0

    iget v0, p1, Landroid/text/TextPaint;->linkColor:I

    goto :goto_0

    :cond_0
    iget v0, p0, Lcom/mg/ola/common/d/a/a;->a:I

    :goto_0
    invoke-virtual {p1, v0}, Landroid/text/TextPaint;->setColor(I)V

    iget-boolean v0, p0, Lcom/mg/ola/common/d/a/a;->b:Z

    invoke-virtual {p1, v0}, Landroid/text/TextPaint;->setUnderlineText(Z)V

    return-void
.end method
