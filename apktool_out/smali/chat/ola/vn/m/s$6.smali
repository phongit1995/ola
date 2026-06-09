.class Lchat/ola/vn/m/s$6;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/s;->a(Landroid/content/Context;)Ljava/util/ArrayList;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/s;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/s;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/s$6;->a:Lchat/ola/vn/m/s;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/s$6;->a:Lchat/ola/vn/m/s;

    invoke-virtual {p1}, Lchat/ola/vn/m/s;->e()Lchat/ola/vn/m/g;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/m/g;->v()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
