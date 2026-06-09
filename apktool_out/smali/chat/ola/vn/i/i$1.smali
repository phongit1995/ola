.class final Lchat/ola/vn/i/i$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;)Lchat/ola/vn/i/p;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Landroid/content/Context;


# direct methods
.method constructor <init>(Ljava/lang/String;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/i$1;->a:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/i/i$1;->b:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/i/i$1;->a:Ljava/lang/String;

    move-object v1, p1

    check-cast v1, Lchat/ola/vn/i/p;

    invoke-virtual {v1}, Lchat/ola/vn/i/p;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->k(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/i/i$1;->b:Landroid/content/Context;

    const v0, 0x7f0f032f

    invoke-static {p2, v0}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;I)V
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
