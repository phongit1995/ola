.class Lchat/ola/vn/m/w$6;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/m/w;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/w;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/w;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/w$6;->a:Lchat/ola/vn/m/w;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/w$6;->a:Lchat/ola/vn/m/w;

    invoke-static {v0}, Lchat/ola/vn/m/w;->b(Lchat/ola/vn/m/w;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method
