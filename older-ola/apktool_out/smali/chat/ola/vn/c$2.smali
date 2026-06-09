.class Lchat/ola/vn/c$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/c;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/c;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c$2;->b:Lchat/ola/vn/c;

    iput-object p2, p0, Lchat/ola/vn/c$2;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c$2;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c$2;->b:Lchat/ola/vn/c;

    const v1, 0x7f0f0172

    invoke-virtual {v0, v1}, Lchat/ola/vn/c;->getString(I)Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/c$2;->b:Lchat/ola/vn/c;

    const v3, 0x7f0f00a2

    invoke-virtual {v2, v3}, Lchat/ola/vn/c;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2, v0}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
