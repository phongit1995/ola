.class Lchat/ola/vn/util/http/WebAppInterfaceImp$5;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/http/WebAppInterfaceImp;->showPostMeForm(JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:[Ljava/lang/String;

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:Ljava/lang/String;

.field final synthetic f:Lchat/ola/vn/util/http/WebAppInterfaceImp;


# direct methods
.method constructor <init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;JLjava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->f:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    iput-wide p2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->a:J

    iput-object p4, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->b:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->c:[Ljava/lang/String;

    iput-object p6, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->d:Ljava/lang/String;

    iput-object p7, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->e:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    :try_start_0
    iget-wide v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->a:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    const/4 v0, 0x0

    const/4 v1, 0x0

    if-lez v4, :cond_3

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->b:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->c:[Ljava/lang/String;

    if-eqz v2, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->c:[Ljava/lang/String;

    array-length v2, v2

    invoke-direct {v0, v2}, Ljava/util/ArrayList;-><init>(I)V

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->c:[Ljava/lang/String;

    array-length v2, v2

    if-ge v1, v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->c:[Ljava/lang/String;

    aget-object v2, v2, v1

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    move-object v4, v0

    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->f:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    invoke-static {v0}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$000(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->d:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->e:Ljava/lang/String;

    iget-wide v5, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->a:J

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;J)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->b:Ljava/lang/String;

    const-string v2, "1"

    invoke-static {v0, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->c:[Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->c:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->f:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    invoke-static {v0}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$000(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/content/Context;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->e:Ljava/lang/String;

    const/4 v4, 0x0

    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->c:[Ljava/lang/String;

    aget-object v5, v0, v1

    iget-wide v6, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->a:J

    invoke-static/range {v2 .. v7}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->f:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    invoke-static {v0}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$000(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->e:Ljava/lang/String;

    const/4 v3, 0x0

    const/4 v4, 0x0

    iget-wide v5, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->a:J

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    return-void

    :cond_3
    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->c:[Ljava/lang/String;

    if-eqz v2, :cond_4

    new-instance v0, Ljava/util/ArrayList;

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->c:[Ljava/lang/String;

    array-length v2, v2

    invoke-direct {v0, v2}, Ljava/util/ArrayList;-><init>(I)V

    :goto_1
    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->c:[Ljava/lang/String;

    array-length v2, v2

    if-ge v1, v2, :cond_4

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->c:[Ljava/lang/String;

    aget-object v2, v2, v1

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_4
    iget-object v1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->f:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    invoke-static {v1}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$000(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->d:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;->e:Ljava/lang/String;

    invoke-static {v1, v2, v3, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    :try_start_1
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_5
    return-void
.end method
