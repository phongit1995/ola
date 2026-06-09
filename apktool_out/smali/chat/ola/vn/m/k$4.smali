.class Lchat/ola/vn/m/k$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/k;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/j;

.field final synthetic b:Lchat/ola/vn/m/k;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/k;Lchat/ola/vn/entity/j;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/k$4;->b:Lchat/ola/vn/m/k;

    iput-object p2, p0, Lchat/ola/vn/m/k$4;->a:Lchat/ola/vn/entity/j;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/m/k$4;->a:Lchat/ola/vn/entity/j;

    iget-object p2, p2, Lchat/ola/vn/entity/j;->a:[Lchat/ola/vn/entity/d;

    const/4 v0, 0x0

    aget-object p2, p2, v0

    invoke-virtual {p2}, Lchat/ola/vn/entity/d;->b()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object p2, p0, Lchat/ola/vn/m/k$4;->a:Lchat/ola/vn/entity/j;

    iget-object p2, p2, Lchat/ola/vn/entity/j;->a:[Lchat/ola/vn/entity/d;

    aget-object p2, p2, v0

    invoke-virtual {p2}, Lchat/ola/vn/entity/d;->c()Ljava/lang/String;

    move-result-object p2

    :cond_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, p2}, Lchat/ola/vn/network/OlaNetworkService;->D(Ljava/lang/String;)V

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/m/k$4;->a:Lchat/ola/vn/entity/j;

    iget-object v2, v2, Lchat/ola/vn/entity/j;->d:Ljava/lang/String;

    aput-object v2, v1, v0

    invoke-virtual {p2, v1}, Lchat/ola/vn/network/OlaNetworkService;->d([Ljava/lang/String;)V

    sget-object p2, Lchat/ola/vn/m/k;->a:Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/m/k$4;->a:Lchat/ola/vn/entity/j;

    invoke-interface {p2, v0}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object p2, p0, Lchat/ola/vn/m/k$4;->b:Lchat/ola/vn/m/k;

    invoke-static {p2}, Lchat/ola/vn/m/k;->a(Lchat/ola/vn/m/k;)Lchat/ola/vn/b/x;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/b/x;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    :try_start_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method
