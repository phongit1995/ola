.class Lchat/ola/vn/m/x$6;
.super Lchat/ola/vn/entry/c/d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/x;->a(Lchat/ola/vn/entity/t;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/x;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/x;Lchat/ola/vn/entity/t;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/x$6;->a:Lchat/ola/vn/m/x;

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/entry/c/d;-><init>(Lchat/ola/vn/entity/t;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Lchat/ola/vn/entry/c/d;->a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/x$6;->a:Lchat/ola/vn/m/x;

    invoke-static {p1}, Lchat/ola/vn/m/x;->c(Lchat/ola/vn/m/x;)Landroid/view/View;

    move-result-object p1

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/entry/c/d;->a([Ljava/lang/Object;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/x$6;->a:Lchat/ola/vn/m/x;

    invoke-static {p1}, Lchat/ola/vn/m/x;->c(Lchat/ola/vn/m/x;)Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/x$6;->a:Lchat/ola/vn/m/x;

    invoke-static {p1}, Lchat/ola/vn/m/x;->a(Lchat/ola/vn/m/x;)Lchat/ola/vn/view/OlaListView;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/x$6;->a:Lchat/ola/vn/m/x;

    invoke-static {v0}, Lchat/ola/vn/m/x;->b(Lchat/ola/vn/m/x;)Lchat/ola/vn/b/aj;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/m/x$6;->a:Lchat/ola/vn/m/x;

    invoke-virtual {p1}, Lchat/ola/vn/m/x;->d()V

    iget-object p1, p0, Lchat/ola/vn/m/x$6;->a:Lchat/ola/vn/m/x;

    invoke-virtual {p1}, Lchat/ola/vn/m/x;->h()V

    iget-object p1, p0, Lchat/ola/vn/m/x$6;->a:Lchat/ola/vn/m/x;

    invoke-virtual {p1}, Lchat/ola/vn/m/x;->f()Lchat/ola/vn/m/j;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/m/j;->d()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
