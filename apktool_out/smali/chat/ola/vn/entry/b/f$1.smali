.class Lchat/ola/vn/entry/b/f$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/f;-><init>(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/f;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/f$1;->a:Lchat/ola/vn/entry/b/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090158

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/entry/b/f;->s:Lchat/ola/vn/entry/b/f;

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/entry/b/f;->s:Lchat/ola/vn/entry/b/f;

    iget-object v0, p0, Lchat/ola/vn/entry/b/f$1;->a:Lchat/ola/vn/entry/b/f;

    if-eq p1, v0, :cond_1

    sget-object p1, Lchat/ola/vn/entry/b/f;->s:Lchat/ola/vn/entry/b/f;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b/f;->c()V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/f$1;->a:Lchat/ola/vn/entry/b/f;

    sput-object p1, Lchat/ola/vn/entry/b/f;->s:Lchat/ola/vn/entry/b/f;

    iget-object p1, p0, Lchat/ola/vn/entry/b/f$1;->a:Lchat/ola/vn/entry/b/f;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b/f;->d()V

    return-void
.end method
