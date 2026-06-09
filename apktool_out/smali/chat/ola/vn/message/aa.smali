.class public Lchat/ola/vn/message/aa;
.super Lchat/ola/vn/message/d;


# instance fields
.field public A:Ljava/lang/Long;

.field public B:Ljava/lang/Long;

.field public C:Lchat/ola/vn/entry/b/ah;

.field protected D:Z

.field protected E:Z

.field private F:Ljava/lang/String;

.field private G:Ljava/lang/String;

.field public z:B


# direct methods
.method public constructor <init>(Lchat/ola/vn/message/d;B)V
    .locals 1

    const/4 v0, 0x3

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/message/d;-><init>(Lchat/ola/vn/message/d;BB)V

    const/4 p1, 0x0

    iput-byte p1, p0, Lchat/ola/vn/message/aa;->z:B

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/message/aa;->A:Ljava/lang/Long;

    iput-object p2, p0, Lchat/ola/vn/message/aa;->B:Ljava/lang/Long;

    iput-boolean p1, p0, Lchat/ola/vn/message/aa;->D:Z

    iput-boolean p1, p0, Lchat/ola/vn/message/aa;->E:Z

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/message/aa;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/message/aa;->G:Ljava/lang/String;

    return-object p0
.end method


# virtual methods
.method public C()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/aa;->G:Ljava/lang/String;

    return-object v0
.end method

.method public D()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/message/aa;->D:Z

    return v0
.end method

.method public E()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/message/aa;->E:Z

    return v0
.end method

.method public F()V
    .locals 4

    const/4 v0, 0x1

    :try_start_0
    iput-boolean v0, p0, Lchat/ola/vn/message/aa;->E:Z

    iget-object v1, p0, Lchat/ola/vn/message/aa;->G:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/entity/i;->l(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/message/aa$1;

    invoke-direct {v2, p0}, Lchat/ola/vn/message/aa$1;-><init>(Lchat/ola/vn/message/aa;)V

    new-array v0, v0, [Ljava/lang/String;

    const/4 v3, 0x0

    aput-object v1, v0, v3

    invoke-virtual {v2, v0}, Lchat/ola/vn/message/aa$1;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/aa;->F:Ljava/lang/String;

    return-object v0
.end method

.method public a(Ljava/lang/String;)V
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    const/4 v0, 0x0

    iput-byte v0, p0, Lchat/ola/vn/message/aa;->z:B

    iput-object p1, p0, Lchat/ola/vn/message/aa;->F:Ljava/lang/String;

    :try_start_0
    invoke-static {}, Lcom/mg/ola/common/d/g;->b()Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Landroid/media/MediaMetadataRetriever;

    invoke-direct {v0}, Landroid/media/MediaMetadataRetriever;-><init>()V

    invoke-virtual {v0, p1}, Landroid/media/MediaMetadataRetriever;->setDataSource(Ljava/lang/String;)V

    const/16 p1, 0x9

    invoke-virtual {v0, p1}, Landroid/media/MediaMetadataRetriever;->extractMetadata(I)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/message/aa;->A:Ljava/lang/Long;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;I)V
    .locals 2

    const/4 v0, 0x1

    :try_start_0
    iput-boolean v0, p0, Lchat/ola/vn/message/aa;->D:Z

    int-to-long v0, p2

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/message/aa;->A:Ljava/lang/Long;

    iget-object p2, p0, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    invoke-virtual {p2, p1}, Lchat/ola/vn/entry/b/ah;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;II)V
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iput-boolean v0, p0, Lchat/ola/vn/message/aa;->D:Z

    int-to-long v0, p3

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/aa;->A:Ljava/lang/Long;

    int-to-long v0, p2

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/aa;->B:Ljava/lang/Long;

    iget-object v0, p0, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/entry/b/ah;->c(Ljava/lang/String;II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    :try_start_0
    iput-object p2, p0, Lchat/ola/vn/message/aa;->F:Ljava/lang/String;

    invoke-static {}, Lcom/mg/ola/common/d/g;->b()Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Landroid/media/MediaMetadataRetriever;

    invoke-direct {v0}, Landroid/media/MediaMetadataRetriever;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/message/aa;->F:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/media/MediaMetadataRetriever;->setDataSource(Ljava/lang/String;)V

    const/16 v1, 0x9

    invoke-virtual {v0, v1}, Landroid/media/MediaMetadataRetriever;->extractMetadata(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/aa;->A:Ljava/lang/Long;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    :try_start_1
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/entry/b/ah;->a(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public b(Ljava/lang/String;II)V
    .locals 2

    int-to-long v0, p3

    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/aa;->A:Ljava/lang/Long;

    int-to-long v0, p2

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/aa;->B:Ljava/lang/Long;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/message/aa;->D:Z

    iget-object v0, p0, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/entry/b/ah;->a(Ljava/lang/String;II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/entry/b/ah;->b(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c(Ljava/lang/String;II)V
    .locals 2

    int-to-long v0, p3

    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/aa;->A:Ljava/lang/Long;

    int-to-long v0, p2

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/aa;->B:Ljava/lang/Long;

    iget-object v0, p0, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/entry/b/ah;->b(Ljava/lang/String;II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public d(Ljava/lang/String;II)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/entry/b/ah;->d(Ljava/lang/String;II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected h()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public n(Ljava/lang/String;)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/message/aa;->G:Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iput-object p1, p0, Lchat/ola/vn/message/aa;->G:Ljava/lang/String;

    new-instance v0, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->l()Ljava/io/File;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ".voice."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "."

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p1, p0, Lchat/ola/vn/message/aa;->l:Ljava/lang/String;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ".tmp"

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, v1, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0, p1}, Lchat/ola/vn/message/aa;->a(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public o(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    invoke-virtual {v0, p1}, Lchat/ola/vn/entry/b/ah;->c(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public p(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    invoke-virtual {v0, p1}, Lchat/ola/vn/entry/b/ah;->d(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public q(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    invoke-virtual {v0, p1}, Lchat/ola/vn/entry/b/ah;->e(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public r(Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iput-boolean v0, p0, Lchat/ola/vn/message/aa;->D:Z

    const-wide/16 v0, 0x0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/aa;->B:Ljava/lang/Long;

    iget-object v0, p0, Lchat/ola/vn/message/aa;->C:Lchat/ola/vn/entry/b/ah;

    invoke-virtual {v0, p1}, Lchat/ola/vn/entry/b/ah;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public w()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method
