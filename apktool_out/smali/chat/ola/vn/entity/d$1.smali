.class final Lchat/ola/vn/entity/d$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entity/d;->a(Landroid/content/Context;Lchat/ola/vn/entity/d;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:Lchat/ola/vn/entity/d;


# direct methods
.method constructor <init>(Landroid/content/Context;Lchat/ola/vn/entity/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/d$1;->a:Landroid/content/Context;

    iput-object p2, p0, Lchat/ola/vn/entity/d$1;->b:Lchat/ola/vn/entity/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/entity/d$1;->a:Landroid/content/Context;

    iget-object v0, p0, Lchat/ola/vn/entity/d$1;->b:Lchat/ola/vn/entity/d;

    invoke-static {p2, v0}, Lchat/ola/vn/entity/d;->b(Landroid/content/Context;Lchat/ola/vn/entity/d;)V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
