.class Lchat/ola/vn/transferken/b$3;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/transferken/b;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/transferken/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/transferken/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/transferken/b$3;->a:Lchat/ola/vn/transferken/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(I)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/transferken/b$3;->a:Lchat/ola/vn/transferken/b;

    invoke-virtual {p1}, Lchat/ola/vn/transferken/b;->e()Lchat/ola/vn/transferken/OlaTransferKenActivity;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->c(Z)V

    iget-object p1, p0, Lchat/ola/vn/transferken/b$3;->a:Lchat/ola/vn/transferken/b;

    invoke-virtual {p1}, Lchat/ola/vn/transferken/b;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const v0, 0x7f0f009f

    const v1, 0x7f0f0443

    invoke-static {p1, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ag;)V
    .locals 1

    sput-object p1, Lchat/ola/vn/transferken/c;->c:Lchat/ola/vn/entity/ag;

    iget-object p1, p0, Lchat/ola/vn/transferken/b$3;->a:Lchat/ola/vn/transferken/b;

    invoke-virtual {p1}, Lchat/ola/vn/transferken/b;->e()Lchat/ola/vn/transferken/OlaTransferKenActivity;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->c(Z)V

    iget-object p1, p0, Lchat/ola/vn/transferken/b$3;->a:Lchat/ola/vn/transferken/b;

    invoke-virtual {p1}, Lchat/ola/vn/transferken/b;->e()Lchat/ola/vn/transferken/OlaTransferKenActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->B()V

    return-void
.end method
