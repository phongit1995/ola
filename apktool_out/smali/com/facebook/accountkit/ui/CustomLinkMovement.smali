.class final Lcom/facebook/accountkit/ui/CustomLinkMovement;
.super Landroid/text/method/LinkMovementMethod;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/ui/CustomLinkMovement$OnURLClickedListener;
    }
.end annotation


# instance fields
.field private final listener:Lcom/facebook/accountkit/ui/CustomLinkMovement$OnURLClickedListener;


# direct methods
.method public constructor <init>(Lcom/facebook/accountkit/ui/CustomLinkMovement$OnURLClickedListener;)V
    .locals 0

    invoke-direct {p0}, Landroid/text/method/LinkMovementMethod;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/CustomLinkMovement;->listener:Lcom/facebook/accountkit/ui/CustomLinkMovement$OnURLClickedListener;

    return-void
.end method


# virtual methods
.method public onTouchEvent(Landroid/widget/TextView;Landroid/text/Spannable;Landroid/view/MotionEvent;)Z
    .locals 3

    invoke-virtual {p3}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    invoke-virtual {p3}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    float-to-int v0, v0

    invoke-virtual {p1}, Landroid/widget/TextView;->getTotalPaddingLeft()I

    move-result v1

    sub-int/2addr v0, v1

    invoke-virtual {p1}, Landroid/widget/TextView;->getScrollX()I

    move-result v1

    add-int/2addr v0, v1

    invoke-virtual {p3}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    float-to-int v1, v1

    invoke-virtual {p1}, Landroid/widget/TextView;->getTotalPaddingTop()I

    move-result v2

    sub-int/2addr v1, v2

    invoke-virtual {p1}, Landroid/widget/TextView;->getScrollY()I

    move-result v2

    add-int/2addr v1, v2

    invoke-virtual {p1}, Landroid/widget/TextView;->getLayout()Landroid/text/Layout;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/text/Layout;->getLineForVertical(I)I

    move-result v1

    int-to-float v0, v0

    invoke-virtual {v2, v1, v0}, Landroid/text/Layout;->getOffsetForHorizontal(IF)I

    move-result v0

    const-class v1, Landroid/text/style/URLSpan;

    invoke-interface {p2, v0, v0, v1}, Landroid/text/Spannable;->getSpans(IILjava/lang/Class;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Landroid/text/style/URLSpan;

    array-length v1, v0

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0}, Landroid/text/style/URLSpan;->getURL()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/facebook/accountkit/ui/CustomLinkMovement;->listener:Lcom/facebook/accountkit/ui/CustomLinkMovement$OnURLClickedListener;

    invoke-interface {v1, v0}, Lcom/facebook/accountkit/ui/CustomLinkMovement$OnURLClickedListener;->onURLClicked(Ljava/lang/String;)V

    :cond_0
    invoke-super {p0, p1, p2, p3}, Landroid/text/method/LinkMovementMethod;->onTouchEvent(Landroid/widget/TextView;Landroid/text/Spannable;Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method
