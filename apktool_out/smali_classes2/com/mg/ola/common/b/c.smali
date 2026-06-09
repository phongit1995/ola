.class public Lcom/mg/ola/common/b/c;
.super Lcom/mg/ola/common/b/a;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/mg/ola/common/b/a<",
        "Ljava/lang/Long;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>(Landroid/content/Context;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/mg/ola/common/b/a;-><init>(Landroid/content/Context;I)V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Long;)Ljava/lang/Long;
    .locals 4

    invoke-virtual {p0}, Lcom/mg/ola/common/b/c;->c()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-virtual {p0}, Lcom/mg/ola/common/b/c;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    return-object p1
.end method

.method public b(Ljava/lang/Long;)V
    .locals 4

    invoke-virtual {p0}, Lcom/mg/ola/common/b/c;->b()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0}, Lcom/mg/ola/common/b/c;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    return-void
.end method
