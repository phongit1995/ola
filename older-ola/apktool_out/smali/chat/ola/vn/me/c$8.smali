.class Lchat/ola/vn/me/c$8;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/c;->e(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c$8;->a:Lchat/ola/vn/me/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/me/c$8;->a:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->l(Lchat/ola/vn/me/c;)Landroid/os/Parcelable;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/c$8;->a:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->k(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaListView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/c$8;->a:Lchat/ola/vn/me/c;

    invoke-static {v1}, Lchat/ola/vn/me/c;->l(Lchat/ola/vn/me/c;)Landroid/os/Parcelable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaListView;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    iget-object v0, p0, Lchat/ola/vn/me/c$8;->a:Lchat/ola/vn/me/c;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/me/c;->a(Lchat/ola/vn/me/c;Landroid/os/Parcelable;)Landroid/os/Parcelable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/c$8;->a:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->k(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaListView;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaListView;->setSelection(I)V

    iget-object v0, p0, Lchat/ola/vn/me/c$8;->a:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->d(Lchat/ola/vn/me/c;)Landroid/view/View;

    move-result-object v0

    sget-object v2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v2}, Lchat/ola/vn/r/a/e;->m()Z

    move-result v2

    if-eqz v2, :cond_1

    goto :goto_0

    :cond_1
    const/16 v1, 0x8

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method
