.class Lchat/ola/vn/q/b$8;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/q/b;->b(Landroid/content/Context;Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:Lchat/ola/vn/q/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/q/b;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/q/b$8;->b:Lchat/ola/vn/q/b;

    iput-object p2, p0, Lchat/ola/vn/q/b$8;->a:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/q/b$8;->a:Landroid/content/Context;

    invoke-static {v0}, Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
