.class final Lchat/ola/vn/activity/OlaCropImageActivity$10;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaCropImageActivity;->d(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Landroid/app/Dialog;

.field final synthetic c:Landroid/content/Context;

.field final synthetic d:I

.field final synthetic e:Lchat/ola/vn/activity/OlaCropImageActivity$a;


# direct methods
.method constructor <init>(Ljava/lang/String;Landroid/app/Dialog;Landroid/content/Context;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->a:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->b:Landroid/app/Dialog;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->c:Landroid/content/Context;

    iput p4, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->d:I

    iput-object p5, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->e:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/c/f;)V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->a:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->h()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->b:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V

    new-instance v0, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->m()Ljava/io/File;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ".crop."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v3, ".tmp"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->c()Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-static {p1, v0}, Lcom/mg/ola/common/d/c;->a(Landroid/graphics/Bitmap;Ljava/io/File;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->c:Landroid/content/Context;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    iget v1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->d:I

    iget-object v2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->e:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    invoke-static {p1, v0, v1, v2}, Lchat/ola/vn/activity/OlaCropImageActivity;->b(Landroid/content/Context;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(Lchat/ola/vn/c/f;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->a:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->h()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->b:Landroid/app/Dialog;

    invoke-virtual {p1}, Landroid/app/Dialog;->dismiss()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$10;->e:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    invoke-interface {p1}, Lchat/ola/vn/activity/OlaCropImageActivity$a;->F()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method
