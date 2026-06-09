.class Lchat/ola/vn/entry/b/x$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/x;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/x;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/x;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/x$2;->a:Lchat/ola/vn/entry/b/x;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 2

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result p2

    const/4 v0, 0x1

    if-eq p2, v0, :cond_0

    const/4 v1, 0x6

    if-eq p2, v1, :cond_0

    return v0

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/entry/b/x$2;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {p2}, Lchat/ola/vn/entry/b/x;->a(Lchat/ola/vn/entry/b/x;)Lchat/ola/vn/entity/k;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/x$2;->a:Lchat/ola/vn/entry/b/x;

    iget-object p2, p2, Lchat/ola/vn/entry/b/x;->a:Landroid/view/View$OnClickListener;

    invoke-interface {p2, p1}, Landroid/view/View$OnClickListener;->onClick(Landroid/view/View;)V

    return v0
.end method
