.class final Lchat/ola/vn/util/b$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/b;->b(Landroid/content/Context;Ljava/lang/String;II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/b$3;->a:Landroid/content/Context;

    iput-object p2, p0, Lchat/ola/vn/util/b$3;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 6

    :try_start_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    if-nez p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/util/b$3;->a:Landroid/content/Context;

    invoke-static {p1}, Lchat/ola/vn/util/b;->b(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    return-void

    :cond_0
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/util/b$3;->a:Landroid/content/Context;

    move-object v0, p1

    check-cast v0, Landroid/app/Activity;

    iget-object p1, p0, Lchat/ola/vn/util/b$3;->a:Landroid/content/Context;

    const p2, 0x7f0f03b5

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/util/b$3;->b:Ljava/lang/String;

    const/4 v3, 0x0

    const/4 v4, 0x1

    const/4 v5, 0x0

    invoke-static/range {v0 .. v5}, Lcom/google/android/youtube/player/YouTubeStandalonePlayer;->createVideoIntent(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;IZZ)Landroid/content/Intent;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/util/b$3;->a:Landroid/content/Context;

    invoke-virtual {p2, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/util/b$3;->a:Landroid/content/Context;

    invoke-static {p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method
