.class Lchat/ola/vn/entry/b/f$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/f;-><init>(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/f;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/f$2;->a:Lchat/ola/vn/entry/b/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/f$2;->a:Lchat/ola/vn/entry/b/f;

    invoke-static {p1}, Lchat/ola/vn/entry/b/f;->a(Lchat/ola/vn/entry/b/f;)Lchat/ola/vn/message/d;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->z()Ljava/lang/Runnable;

    move-result-object p1

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
