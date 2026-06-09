.class Lchat/ola/vn/me/c$11;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/c;->a(Lchat/ola/vn/entry/a;Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:I

.field final synthetic c:Lchat/ola/vn/me/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/c;II)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c$11;->c:Lchat/ola/vn/me/c;

    iput p2, p0, Lchat/ola/vn/me/c$11;->a:I

    iput p3, p0, Lchat/ola/vn/me/c$11;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/me/c$11;->c:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->l(Lchat/ola/vn/me/c;)Landroid/os/Parcelable;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/c$11;->c:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->k(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaListView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/c$11;->c:Lchat/ola/vn/me/c;

    invoke-static {v1}, Lchat/ola/vn/me/c;->l(Lchat/ola/vn/me/c;)Landroid/os/Parcelable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaListView;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    iget-object v0, p0, Lchat/ola/vn/me/c$11;->c:Lchat/ola/vn/me/c;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/me/c;->a(Lchat/ola/vn/me/c;Landroid/os/Parcelable;)Landroid/os/Parcelable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/c$11;->c:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->k(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaListView;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/me/c$11$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/c$11$1;-><init>(Lchat/ola/vn/me/c$11;)V

    const-wide/16 v2, 0xfa

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/view/OlaListView;->postDelayed(Ljava/lang/Runnable;J)Z

    iget-object v0, p0, Lchat/ola/vn/me/c$11;->c:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->d(Lchat/ola/vn/me/c;)Landroid/view/View;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->m()Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 v1, 0x0

    goto :goto_0

    :cond_1
    const/16 v1, 0x8

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method
