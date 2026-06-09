.class public Lchat/ola/vn/entity/OlaVenueEntity;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/io/Serializable;


# static fields
.field private static final serialVersionUID:J = 0x1L


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:Ljava/lang/String;

.field private h:Ljava/lang/String;

.field private i:Ljava/lang/String;

.field private j:I

.field private k:J

.field private l:J


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/entity/OlaVenueEntity;->l:J

    return-void
.end method


# virtual methods
.method public a()Lorg/json/JSONObject;
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entity/OlaVenueEntity;->b:Ljava/lang/String;

    if-eqz v0, :cond_0

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "venueId"

    iget-object v2, p0, Lchat/ola/vn/entity/OlaVenueEntity;->b:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "timeStamp"

    iget-wide v2, p0, Lchat/ola/vn/entity/OlaVenueEntity;->l:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->j:I

    return-void
.end method

.method public a(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->k:J

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->b:Ljava/lang/String;

    return-void
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/OlaVenueEntity;->b:Ljava/lang/String;

    return-object v0
.end method

.method public b(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->l:J

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->c:Ljava/lang/String;

    return-void
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/OlaVenueEntity;->c:Ljava/lang/String;

    return-object v0
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->d:Ljava/lang/String;

    return-void
.end method

.method public d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/OlaVenueEntity;->d:Ljava/lang/String;

    return-object v0
.end method

.method public d(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->e:Ljava/lang/String;

    return-void
.end method

.method public e()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/OlaVenueEntity;->e:Ljava/lang/String;

    return-object v0
.end method

.method public e(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->f:Ljava/lang/String;

    return-void
.end method

.method public f()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/OlaVenueEntity;->f:Ljava/lang/String;

    return-object v0
.end method

.method public f(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->g:Ljava/lang/String;

    return-void
.end method

.method public g()Lchat/ola/vn/entity/OlaVenueEntity;
    .locals 3

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {v0}, Lchat/ola/vn/entity/OlaVenueEntity;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->b:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/entity/OlaVenueEntity;->b:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->e:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/entity/OlaVenueEntity;->e:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->d:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/entity/OlaVenueEntity;->d:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->f:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/entity/OlaVenueEntity;->f:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->c:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/entity/OlaVenueEntity;->c:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->g:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/entity/OlaVenueEntity;->g:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->h:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/entity/OlaVenueEntity;->h:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->i:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/entity/OlaVenueEntity;->i:Ljava/lang/String;

    iget v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->j:I

    iput v1, v0, Lchat/ola/vn/entity/OlaVenueEntity;->j:I

    iget-wide v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->k:J

    iput-wide v1, v0, Lchat/ola/vn/entity/OlaVenueEntity;->k:J
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 v0, 0x0

    return-object v0
.end method

.method public g(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->h:Ljava/lang/String;

    return-void
.end method

.method public h()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/OlaVenueEntity;->i:Ljava/lang/String;

    return-object v0
.end method

.method public h(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->i:Ljava/lang/String;

    return-void
.end method

.method public i()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/OlaVenueEntity;->j:I

    return v0
.end method

.method public i(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->a:Ljava/lang/String;

    return-void
.end method

.method public j()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/OlaVenueEntity;->a:Ljava/lang/String;

    return-object v0
.end method

.method public k()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/OlaVenueEntity;->l:J

    return-wide v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[ID: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "] [NAME: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "] [DESCRIPTION: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "] [MEDIA: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->f:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "] [ADDRESS: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entity/OlaVenueEntity;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    invoke-super {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
