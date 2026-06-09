.class Lchat/ola/vn/entry/b/ae$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/ae;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/ae;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/ae;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/ae$1;->a:Lchat/ola/vn/entry/b/ae;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4

    const/4 v0, 0x1

    if-eq p2, v0, :cond_0

    goto :goto_0

    :cond_0
    const-wide/16 v0, 0x0

    :try_start_0
    move-object p2, p1

    check-cast p2, Lchat/ola/vn/i/p;

    invoke-virtual {p2}, Lchat/ola/vn/i/p;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-static {p2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/entry/b/ae$1;->a:Lchat/ola/vn/entry/b/ae;

    invoke-static {p2}, Lchat/ola/vn/entry/b/ae;->a(Lchat/ola/vn/entry/b/ae;)Lchat/ola/vn/message/q;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/q;->C()J

    move-result-wide v2

    cmp-long p2, v0, v2

    if-eqz p2, :cond_2

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p2

    const v0, 0x7f0f02ea

    invoke-static {p2, v0}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V

    goto :goto_0

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/entry/b/ae$1;->a:Lchat/ola/vn/entry/b/ae;

    invoke-static {p2}, Lchat/ola/vn/entry/b/ae;->b(Lchat/ola/vn/entry/b/ae;)V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
