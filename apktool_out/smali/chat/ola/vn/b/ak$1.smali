.class Lchat/ola/vn/b/ak$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/b/ak;->a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:Lchat/ola/vn/message/f;

.field final synthetic c:Lchat/ola/vn/b/ak;


# direct methods
.method constructor <init>(Lchat/ola/vn/b/ak;ILchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/ak$1;->c:Lchat/ola/vn/b/ak;

    iput p2, p0, Lchat/ola/vn/b/ak$1;->a:I

    iput-object p3, p0, Lchat/ola/vn/b/ak$1;->b:Lchat/ola/vn/message/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/b/ak$1;->c:Lchat/ola/vn/b/ak;

    iget v0, p0, Lchat/ola/vn/b/ak$1;->a:I

    invoke-virtual {p1, v0, p2}, Lchat/ola/vn/b/ak;->a(IZ)V

    iget-object p1, p0, Lchat/ola/vn/b/ak$1;->c:Lchat/ola/vn/b/ak;

    invoke-static {p1}, Lchat/ola/vn/b/ak;->a(Lchat/ola/vn/b/ak;)Lchat/ola/vn/b/ak$b;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/b/ak$1;->c:Lchat/ola/vn/b/ak;

    invoke-static {p1}, Lchat/ola/vn/b/ak;->a(Lchat/ola/vn/b/ak;)Lchat/ola/vn/b/ak$b;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/b/ak$1;->b:Lchat/ola/vn/message/f;

    invoke-interface {p1, p2, v0}, Lchat/ola/vn/b/ak$b;->a(ZLchat/ola/vn/message/f;)V

    :cond_0
    return-void
.end method
