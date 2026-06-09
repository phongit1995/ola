.class Lchat/ola/vn/me/OlaMeComposerActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/n/b$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaMeComposerActivity;->X()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaMeComposerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$2;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(DDF)V
    .locals 2

    :try_start_0
    iget-object p5, p0, Lchat/ola/vn/me/OlaMeComposerActivity$2;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {p5}, Lchat/ola/vn/me/OlaMeComposerActivity;->h(Lchat/ola/vn/me/OlaMeComposerActivity;)Lchat/ola/vn/i/c;

    move-result-object p5

    invoke-virtual {p5}, Lchat/ola/vn/i/c;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const-wide/16 v0, 0x0

    cmpl-double p5, p1, v0

    if-eqz p5, :cond_0

    cmpl-double p1, p3, v0

    if-eqz p1, :cond_0

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$2;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p2

    invoke-static {p1, p2, p3}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Lchat/ola/vn/me/OlaMeComposerActivity;J)J

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$2;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity$2;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {p1, p2}, Lchat/ola/vn/checkin/OlaCheckInActivity;->a(Landroid/content/Context;Lchat/ola/vn/checkin/b;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    return-void

    :cond_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$2;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->h(Lchat/ola/vn/me/OlaMeComposerActivity;)Lchat/ola/vn/i/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/i/c;->a()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$2;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    const p2, 0x7f0f00a2

    const p3, 0x7f0f02b5

    invoke-static {p1, p2, p3}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    return-void
.end method

.method public j_()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity$2;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->h(Lchat/ola/vn/me/OlaMeComposerActivity;)Lchat/ola/vn/i/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    const v1, 0x7f0f009f

    const v2, 0x7f0f02d6

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public k_()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity$2;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->h(Lchat/ola/vn/me/OlaMeComposerActivity;)Lchat/ola/vn/i/c;

    move-result-object v0

    const-wide/16 v1, 0x2710

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public l_()V
    .locals 7

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity$2;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->h(Lchat/ola/vn/me/OlaMeComposerActivity;)Lchat/ola/vn/i/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/i/c;->a()V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    const v2, 0x7f0f02a1

    const v3, 0x7f0f02a2

    const v4, 0x7f0f065f

    const v5, 0x7f0f0480

    new-instance v6, Lchat/ola/vn/me/OlaMeComposerActivity$2$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$2$1;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity$2;)V

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
