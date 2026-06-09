.class public Lchat/ola/vn/e;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/f/a;


# static fields
.field public static a:I = 0x140

.field public static b:I = 0x1e0

.field public static c:I = 0x140

.field public static d:I = 0x1e0

.field public static e:I = 0x26

.field private static f:Lchat/ola/vn/e;


# instance fields
.field private A:Lcom/mg/ola/common/b/d;

.field private B:Lcom/mg/ola/common/b/d;

.field private C:Lcom/mg/ola/common/b/d;

.field private D:Lcom/mg/ola/common/b/d;

.field private E:Lcom/mg/ola/common/b/d;

.field private F:Lcom/mg/ola/common/b/d;

.field private G:Lcom/mg/ola/common/b/b;

.field private H:Lcom/mg/ola/common/b/b;

.field private I:Lcom/mg/ola/common/b/b;

.field private J:Lcom/mg/ola/common/b/b;

.field private K:Lcom/mg/ola/common/b/b;

.field private L:Lcom/mg/ola/common/b/b;

.field private M:Lcom/mg/ola/common/b/b;

.field private N:Lcom/mg/ola/common/b/b;

.field private g:Lcom/mg/ola/common/b/c;

.field private h:Lcom/mg/ola/common/b/c;

.field private i:Lcom/mg/ola/common/b/c;

.field private j:Lcom/mg/ola/common/b/d;

.field private k:Lcom/mg/ola/common/b/d;

.field private l:Lcom/mg/ola/common/b/d;

.field private o:Lcom/mg/ola/common/b/d;

.field private p:Lcom/mg/ola/common/b/d;

.field private q:Lcom/mg/ola/common/b/d;

.field private r:Lcom/mg/ola/common/b/d;

.field private s:Lcom/mg/ola/common/b/d;

.field private t:Lcom/mg/ola/common/b/d;

.field private u:Lcom/mg/ola/common/b/d;

.field private v:Lcom/mg/ola/common/b/d;

.field private w:Lcom/mg/ola/common/b/d;

.field private x:Lcom/mg/ola/common/b/d;

.field private y:Lcom/mg/ola/common/b/d;

.field private z:Lcom/mg/ola/common/b/d;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    :try_start_0
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0139

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->j:Lcom/mg/ola/common/b/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0138

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->l:Lcom/mg/ola/common/b/d;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0146

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->k:Lcom/mg/ola/common/b/d;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0135

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->o:Lcom/mg/ola/common/b/d;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :try_start_4
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0137

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->p:Lcom/mg/ola/common/b/d;
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    :try_start_5
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0113

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->q:Lcom/mg/ola/common/b/d;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_5

    :catch_5
    :try_start_6
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0112

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->r:Lcom/mg/ola/common/b/d;
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_6

    :catch_6
    :try_start_7
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0132

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->s:Lcom/mg/ola/common/b/d;
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_7

    :catch_7
    :try_start_8
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0149

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->t:Lcom/mg/ola/common/b/d;
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_8

    :catch_8
    :try_start_9
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0134

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->u:Lcom/mg/ola/common/b/d;
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_9

    :catch_9
    :try_start_a
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0159

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->v:Lcom/mg/ola/common/b/d;
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_a

    :catch_a
    :try_start_b
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0155

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->w:Lcom/mg/ola/common/b/d;
    :try_end_b
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_b

    :catch_b
    :try_start_c
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0151

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->x:Lcom/mg/ola/common/b/d;
    :try_end_c
    .catch Ljava/lang/Throwable; {:try_start_c .. :try_end_c} :catch_c

    :catch_c
    :try_start_d
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f013b

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->y:Lcom/mg/ola/common/b/d;
    :try_end_d
    .catch Ljava/lang/Throwable; {:try_start_d .. :try_end_d} :catch_d

    :catch_d
    :try_start_e
    new-instance v1, Lcom/mg/ola/common/b/b;

    const v2, 0x7f0f0117

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/b;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->I:Lcom/mg/ola/common/b/b;
    :try_end_e
    .catch Ljava/lang/Throwable; {:try_start_e .. :try_end_e} :catch_e

    :catch_e
    :try_start_f
    new-instance v1, Lcom/mg/ola/common/b/b;

    const v2, 0x7f0f0141

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/b;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->J:Lcom/mg/ola/common/b/b;
    :try_end_f
    .catch Ljava/lang/Throwable; {:try_start_f .. :try_end_f} :catch_f

    :catch_f
    :try_start_10
    new-instance v1, Lcom/mg/ola/common/b/c;

    const v2, 0x7f0f0142

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/c;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->g:Lcom/mg/ola/common/b/c;
    :try_end_10
    .catch Ljava/lang/Throwable; {:try_start_10 .. :try_end_10} :catch_10

    :catch_10
    :try_start_11
    new-instance v1, Lcom/mg/ola/common/b/b;

    const v2, 0x7f0f0156

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/b;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->K:Lcom/mg/ola/common/b/b;
    :try_end_11
    .catch Ljava/lang/Throwable; {:try_start_11 .. :try_end_11} :catch_11

    :catch_11
    :try_start_12
    new-instance v1, Lcom/mg/ola/common/b/b;

    const v2, 0x7f0f0150

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/b;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->L:Lcom/mg/ola/common/b/b;
    :try_end_12
    .catch Ljava/lang/Throwable; {:try_start_12 .. :try_end_12} :catch_12

    :catch_12
    :try_start_13
    new-instance v1, Lcom/mg/ola/common/b/b;

    const v2, 0x7f0f014f

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/b;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->M:Lcom/mg/ola/common/b/b;
    :try_end_13
    .catch Ljava/lang/Throwable; {:try_start_13 .. :try_end_13} :catch_13

    :catch_13
    :try_start_14
    new-instance v1, Lcom/mg/ola/common/b/b;

    const v2, 0x7f0f0148

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/b;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->N:Lcom/mg/ola/common/b/b;
    :try_end_14
    .catch Ljava/lang/Throwable; {:try_start_14 .. :try_end_14} :catch_14

    :catch_14
    :try_start_15
    new-instance v1, Lcom/mg/ola/common/b/c;

    const v2, 0x7f0f013c

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/c;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->i:Lcom/mg/ola/common/b/c;
    :try_end_15
    .catch Ljava/lang/Throwable; {:try_start_15 .. :try_end_15} :catch_15

    :catch_15
    :try_start_16
    new-instance v1, Lcom/mg/ola/common/b/b;

    const v2, 0x7f0f015e

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/b;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->G:Lcom/mg/ola/common/b/b;
    :try_end_16
    .catch Ljava/lang/Throwable; {:try_start_16 .. :try_end_16} :catch_16

    :catch_16
    :try_start_17
    new-instance v1, Lcom/mg/ola/common/b/b;

    const v2, 0x7f0f013a

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/b;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->H:Lcom/mg/ola/common/b/b;
    :try_end_17
    .catch Ljava/lang/Throwable; {:try_start_17 .. :try_end_17} :catch_17

    :catch_17
    :try_start_18
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0157

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->z:Lcom/mg/ola/common/b/d;
    :try_end_18
    .catch Ljava/lang/Throwable; {:try_start_18 .. :try_end_18} :catch_18

    :catch_18
    :try_start_19
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f014c

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->A:Lcom/mg/ola/common/b/d;
    :try_end_19
    .catch Ljava/lang/Throwable; {:try_start_19 .. :try_end_19} :catch_19

    :catch_19
    :try_start_1a
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f014b

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->B:Lcom/mg/ola/common/b/d;
    :try_end_1a
    .catch Ljava/lang/Throwable; {:try_start_1a .. :try_end_1a} :catch_1a

    :catch_1a
    :try_start_1b
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0136

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->C:Lcom/mg/ola/common/b/d;
    :try_end_1b
    .catch Ljava/lang/Throwable; {:try_start_1b .. :try_end_1b} :catch_1b

    :catch_1b
    :try_start_1c
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f013f

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->D:Lcom/mg/ola/common/b/d;
    :try_end_1c
    .catch Ljava/lang/Throwable; {:try_start_1c .. :try_end_1c} :catch_1c

    :catch_1c
    :try_start_1d
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f0114

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->E:Lcom/mg/ola/common/b/d;
    :try_end_1d
    .catch Ljava/lang/Throwable; {:try_start_1d .. :try_end_1d} :catch_1d

    :catch_1d
    :try_start_1e
    new-instance v1, Lcom/mg/ola/common/b/d;

    const v2, 0x7f0f014a

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/d;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->F:Lcom/mg/ola/common/b/d;
    :try_end_1e
    .catch Ljava/lang/Throwable; {:try_start_1e .. :try_end_1e} :catch_1e

    :catch_1e
    :try_start_1f
    new-instance v1, Lcom/mg/ola/common/b/c;

    const v2, 0x7f0f0133

    invoke-direct {v1, v0, v2}, Lcom/mg/ola/common/b/c;-><init>(Landroid/content/Context;I)V

    iput-object v1, p0, Lchat/ola/vn/e;->h:Lcom/mg/ola/common/b/c;
    :try_end_1f
    .catch Ljava/lang/Throwable; {:try_start_1f .. :try_end_1f} :catch_1f

    :catch_1f
    return-void
.end method

.method public static final a()Lchat/ola/vn/e;
    .locals 1

    sget-object v0, Lchat/ola/vn/e;->f:Lchat/ola/vn/e;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/e;

    invoke-direct {v0}, Lchat/ola/vn/e;-><init>()V

    sput-object v0, Lchat/ola/vn/e;->f:Lchat/ola/vn/e;

    :cond_0
    sget-object v0, Lchat/ola/vn/e;->f:Lchat/ola/vn/e;

    return-object v0
.end method

.method private e(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/h/a;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_2

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    :cond_0
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/h/a;

    invoke-virtual {v1}, Lchat/ola/vn/h/a;->a()Lorg/json/JSONObject;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/e;->r:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V

    return-void

    :cond_2
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/e;->r:Lcom/mg/ola/common/b/d;

    const-string v0, ""

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private z()Ljava/util/List;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/p;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/e;->t:Lcom/mg/ola/common/b/d;

    const-string v2, ""

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2, v1}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_1

    invoke-virtual {v2, v3}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    const-string v5, "productId"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "signatureData"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-nez v0, :cond_0

    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v1}, Ljava/util/ArrayList;-><init>(I)V

    move-object v0, v6

    :cond_0
    new-instance v6, Lchat/ola/vn/entity/p;

    invoke-direct {v6}, Lchat/ola/vn/entity/p;-><init>()V

    iput-object v5, v6, Lchat/ola/vn/entity/p;->f:Ljava/lang/String;

    iput-object v4, v6, Lchat/ola/vn/entity/p;->m:Ljava/lang/String;

    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    return-object v0
.end method


# virtual methods
.method public a(I)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->J:Lcom/mg/ola/common/b/b;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/b;->b(Ljava/lang/Integer;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(J)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->g:Lcom/mg/ola/common/b/c;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/c;->b(Ljava/lang/Long;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/e;->j:Lcom/mg/ola/common/b/d;

    const-string v0, ""

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/e;->j:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/e;->n()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    :cond_0
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/h/a;

    iget-object v3, v2, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v3, v3, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v3, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    iput-object p2, v2, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/e;->e(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/e;->n()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    :cond_0
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/h/a;

    iget-object v3, v2, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v3, v3, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v3, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    iput-object p2, v2, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    iput-object p3, v2, Lchat/ola/vn/h/a;->c:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/e;->e(Ljava/util/List;)V

    return-void

    :cond_2
    new-instance v1, Landroid/accounts/Account;

    const v2, 0x7f0f001e

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, p1, v2}, Landroid/accounts/Account;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    new-instance p1, Lchat/ola/vn/h/a;

    invoke-direct {p1}, Lchat/ola/vn/h/a;-><init>()V

    iput-object v1, p1, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iput-object p2, p1, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    iput-object p3, p1, Lchat/ola/vn/h/a;->c:Ljava/lang/String;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p2

    iput-wide p2, p1, Lchat/ola/vn/h/a;->e:J

    iput-object p4, p1, Lchat/ola/vn/h/a;->d:Ljava/lang/String;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-direct {p0, v0}, Lchat/ola/vn/e;->e(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/w;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    const/4 v1, 0x0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    :goto_0
    if-ge v1, v2, :cond_0

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/w;

    invoke-virtual {v3}, Lchat/ola/vn/entity/w;->b()Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONArray;->put(ILjava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/e;->A:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-virtual {p1, v0}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/e;->A:Lcom/mg/ola/common/b/d;

    const-string v0, ""
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    return-void
.end method

.method public b()I
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/e;->I:Lcom/mg/ola/common/b/b;

    invoke-virtual {v2, v1}, Lcom/mg/ola/common/b/b;->a(Ljava/lang/Integer;)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    :catch_0
    return v0
.end method

.method public b(I)V
    .locals 1

    if-gtz p1, :cond_0

    const/4 p1, 0x1

    :cond_0
    const/16 v0, 0xa

    if-le p1, v0, :cond_1

    const/16 p1, 0xa

    :cond_1
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->L:Lcom/mg/ola/common/b/b;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/b;->b(Ljava/lang/Integer;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(J)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->i:Lcom/mg/ola/common/b/c;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/c;->b(Ljava/lang/Long;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/e;->l:Lcom/mg/ola/common/b/d;

    const-string v0, ""

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/e;->l:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/e;->z()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    :cond_1
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/p;

    iget-object v2, v2, Lchat/ola/vn/entity/p;->f:Ljava/lang/String;

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    return-void

    :cond_3
    new-instance v1, Lchat/ola/vn/entity/p;

    invoke-direct {v1}, Lchat/ola/vn/entity/p;-><init>()V

    iput-object p1, v1, Lchat/ola/vn/entity/p;->f:Ljava/lang/String;

    iput-object p2, v1, Lchat/ola/vn/entity/p;->m:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p1, Lorg/json/JSONArray;

    invoke-direct {p1}, Lorg/json/JSONArray;-><init>()V

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/p;

    invoke-virtual {v0}, Lchat/ola/vn/entity/p;->a()Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {p1, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_0

    :cond_4
    invoke-virtual {p1}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/e;->t:Lcom/mg/ola/common/b/d;

    invoke-virtual {p2, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :cond_5
    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_2

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    :cond_0
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    const/4 v1, 0x0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    :goto_0
    if-ge v1, v2, :cond_1

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONArray;->put(ILjava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/e;->F:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V

    return-void

    :cond_2
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/e;->F:Lcom/mg/ola/common/b/d;

    const-string v0, ""

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c()J
    .locals 4

    const-wide/16 v0, 0x0

    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/e;->g:Lcom/mg/ola/common/b/c;

    invoke-virtual {v3, v2}, Lcom/mg/ola/common/b/c;->a(Ljava/lang/Long;)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v2

    :catch_0
    return-wide v0
.end method

.method public c(I)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->M:Lcom/mg/ola/common/b/b;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/b;->b(Ljava/lang/Integer;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c(J)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->h:Lcom/mg/ola/common/b/c;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/c;->b(Ljava/lang/Long;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    if-nez p1, :cond_0

    :try_start_0
    const-string p1, ""

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/e;->p:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/h;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    const/4 v1, 0x0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    :goto_0
    if-ge v1, v2, :cond_0

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entry/h;

    invoke-virtual {v3}, Lchat/ola/vn/entry/h;->c()Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONArray;->put(ILjava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/e;->B:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-virtual {p1, v0}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/e;->B:Lcom/mg/ola/common/b/d;

    const-string v0, ""
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    return-void
.end method

.method public d()I
    .locals 3

    const/4 v0, 0x5

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/e;->L:Lcom/mg/ola/common/b/b;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/b;->a(Ljava/lang/Integer;)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    int-to-short v0, v1

    :catch_0
    return v0
.end method

.method public d(I)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->N:Lcom/mg/ola/common/b/b;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/b;->b(Ljava/lang/Integer;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 1

    if-nez p1, :cond_0

    :try_start_0
    const-string p1, ""

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/e;->q:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public d(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    const/4 v1, 0x0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    :goto_0
    if-ge v1, v2, :cond_0

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaVenueEntity;->a()Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v0, v1, v3}, Lorg/json/JSONArray;->put(ILjava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/e;->C:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-virtual {p1, v0}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/e;->C:Lcom/mg/ola/common/b/d;

    const-string v0, ""
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    return-void
.end method

.method public e()I
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->M:Lcom/mg/ola/common/b/b;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/b/b;->a(Ljava/lang/Integer;)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x5

    return v0
.end method

.method public e(I)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->H:Lcom/mg/ola/common/b/b;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/b;->b(Ljava/lang/Integer;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/e;->n()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    :cond_0
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/h/a;

    iget-object v3, v2, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v3, v3, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v3, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    const-string p1, ""

    iput-object p1, v2, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/e;->e(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public f()S
    .locals 3

    const/4 v0, 0x2

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/e;->N:Lcom/mg/ola/common/b/b;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/b;->a(Ljava/lang/Integer;)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    int-to-short v0, v1

    :catch_0
    return v0
.end method

.method public f(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/e;->n()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    :cond_0
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/h/a;

    iget-object v3, v2, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v3, v3, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v3, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v0, v2}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    invoke-direct {p0, v0}, Lchat/ola/vn/e;->e(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public f(I)Z
    .locals 8

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/e;->k:Lcom/mg/ola/common/b/d;

    const-string v2, ""

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    aget-object v2, v1, v0

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    const/4 v3, 0x1

    aget-object v1, v1, v3

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v4

    if-eq v2, p1, :cond_0

    return v3

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x0

    sub-long v6, v1, v4

    const-wide/32 v1, 0x36ee80

    cmp-long p1, v6, v1

    if-lez p1, :cond_1

    return v3

    :catch_0
    :cond_1
    return v0
.end method

.method public g()I
    .locals 3

    const/16 v0, 0x12

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/e;->G:Lcom/mg/ola/common/b/b;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/b;->a(Ljava/lang/Integer;)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    :catch_0
    return v0
.end method

.method public g(I)V
    .locals 3

    if-gtz p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/e;->k:Lcom/mg/ola/common/b/d;

    const-string v0, ""

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V

    return-void

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, ":"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/e;->k:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 1

    if-nez p1, :cond_0

    :try_start_0
    const-string p1, ""

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/e;->s:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public h()I
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/e;->H:Lcom/mg/ola/common/b/b;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/b;->a(Ljava/lang/Integer;)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/16 v2, 0xe

    if-eq v1, v2, :cond_0

    packed-switch v1, :pswitch_data_0

    return v0

    :cond_0
    :pswitch_0
    move v0, v1

    :catch_0
    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public h(Ljava/lang/String;)V
    .locals 6

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/e;->q()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    :cond_1
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    return-void

    :cond_3
    :goto_0
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    const/16 v2, 0xa

    if-le v1, v2, :cond_4

    add-int/lit8 v1, v1, -0x1

    invoke-interface {v0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_0

    :cond_4
    const/4 v1, 0x0

    invoke-interface {v0, v1, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result p1

    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    :goto_1
    if-ge v1, p1, :cond_5

    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    const-string v4, "path"

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v2, v1, v3}, Lorg/json/JSONArray;->put(ILjava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_5
    invoke-virtual {v2}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/e;->u:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public i()Ljava/lang/String;
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->j:Lcom/mg/ola/common/b/d;

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public i(Ljava/lang/String;)V
    .locals 6

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/e;->q()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v0, v2}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    :cond_3
    :goto_0
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result p1

    const/16 v1, 0xa

    if-le p1, v1, :cond_4

    add-int/lit8 p1, p1, -0x1

    invoke-interface {v0, p1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_0

    :cond_4
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    const/4 v2, 0x0

    :goto_1
    if-ge v2, p1, :cond_5

    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    const-string v4, "path"

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONArray;->put(ILjava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_5
    invoke-virtual {v1}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/e;->u:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public j()Ljava/lang/String;
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->l:Lcom/mg/ola/common/b/d;

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public j(Ljava/lang/String;)V
    .locals 6

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/e;->s()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    :cond_1
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    return-void

    :cond_3
    :goto_0
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    const/16 v2, 0xa

    if-lt v1, v2, :cond_4

    add-int/lit8 v1, v1, -0x1

    invoke-interface {v0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_0

    :cond_4
    const/4 v2, 0x0

    invoke-interface {v0, v2, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    new-instance p1, Lorg/json/JSONArray;

    invoke-direct {p1}, Lorg/json/JSONArray;-><init>()V

    :goto_1
    if-ge v2, v1, :cond_5

    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    const-string v4, "path"

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    invoke-virtual {p1, v2, v3}, Lorg/json/JSONArray;->put(ILjava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_5
    invoke-virtual {p1}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/e;->v:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public k()Ljava/lang/String;
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->p:Lcom/mg/ola/common/b/d;

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public k(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/e;->z()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_2
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/p;

    iget-object v3, v2, Lchat/ola/vn/entity/p;->f:Ljava/lang/String;

    invoke-static {v3, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    invoke-virtual {v2}, Lchat/ola/vn/entity/p;->a()Lorg/json/JSONObject;

    move-result-object v2

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_0

    :cond_3
    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result p1

    if-nez p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/e;->t:Lcom/mg/ola/common/b/d;

    const-string v0, ""

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V

    return-void

    :cond_4
    invoke-virtual {v1}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/e;->t:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public l()Ljava/lang/String;
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->q:Lcom/mg/ola/common/b/d;

    const-string v1, "default"

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public l(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-object v0

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/e;->z()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/p;

    iget-object v3, v2, Lchat/ola/vn/entity/p;->f:Ljava/lang/String;

    invoke-static {p1, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    iget-object p1, v2, Lchat/ola/vn/entity/p;->m:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_2
    return-object v0
.end method

.method public m(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/e;->n()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_1

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/h/a;

    iget-object v2, v1, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v2, v2, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object p1, v1, Lchat/ola/vn/h/a;->b:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public m()Z
    .locals 3

    const/4 v0, 0x1

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/e;->q:Lcom/mg/ola/common/b/d;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_0

    return v0

    :cond_0
    const/4 v0, 0x0

    :catch_0
    return v0
.end method

.method public n(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/e;->n()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_1

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/h/a;

    iget-object v2, v1, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v2, v2, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object p1, v1, Lchat/ola/vn/h/a;->d:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public n()Ljava/util/List;
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/h/a;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/e;->r:Lcom/mg/ola/common/b/d;

    const-string v2, ""

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    return-object v0

    :cond_0
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2, v1}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    if-eqz v2, :cond_7

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_7

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v1

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3, v1}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v1, :cond_5

    invoke-virtual {v2, v4}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    const-string v8, "username"

    invoke-virtual {v5, v8}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_1

    goto :goto_3

    :cond_1
    const-string v8, "username"

    invoke-virtual {v5, v8}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const-string v9, "password"

    invoke-virtual {v5, v9}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_2

    const-string v9, "password"

    invoke-virtual {v5, v9}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    goto :goto_1

    :cond_2
    move-object v9, v0

    :goto_1
    const-string v10, "workingSession"

    invoke-virtual {v5, v10}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_3

    const-string v10, "workingSession"

    invoke-virtual {v5, v10}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    goto :goto_2

    :cond_3
    move-object v10, v0

    :goto_2
    const-string v11, "lastAccessTime"

    invoke-virtual {v5, v11}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_4

    const-string v11, "lastAccessTime"

    invoke-virtual {v5, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    invoke-static {v5}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v11
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-wide v6, v11

    :catch_0
    :cond_4
    :try_start_2
    new-instance v5, Landroid/accounts/Account;

    const v11, 0x7f0f001e

    invoke-static {v11}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v11

    invoke-direct {v5, v8, v11}, Landroid/accounts/Account;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v8, Lchat/ola/vn/h/a;

    invoke-direct {v8}, Lchat/ola/vn/h/a;-><init>()V

    iput-object v5, v8, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iput-object v9, v8, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    iput-object v10, v8, Lchat/ola/vn/h/a;->c:Ljava/lang/String;

    iput-wide v6, v8, Lchat/ola/vn/h/a;->e:J

    invoke-interface {v3, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :goto_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_5
    if-eqz v3, :cond_6

    :try_start_3
    new-instance v0, Lchat/ola/vn/e/a;

    invoke-direct {v0}, Lchat/ola/vn/e/a;-><init>()V

    invoke-static {v3, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :cond_6
    return-object v3

    :catch_2
    move-exception v1

    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_7
    return-object v0
.end method

.method public o()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->u:Lcom/mg/ola/common/b/d;

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public o(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p1, "Ola"

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/e;->D:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public p()Ljava/lang/String;
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/e;->s:Lcom/mg/ola/common/b/d;

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public p(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p1, ""

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/e;->E:Lcom/mg/ola/common/b/d;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/b/d;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public q()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/e;->u:Lcom/mg/ola/common/b/d;

    const-string v2, ""

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2, v1}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_2

    invoke-virtual {v2, v3}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    const-string v5, "path"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-nez v0, :cond_0

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5, v1}, Ljava/util/ArrayList;-><init>(I)V

    move-object v0, v5

    :cond_0
    invoke-static {v4}, Lcom/mg/ola/common/d/c;->a(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :catch_0
    :cond_2
    return-object v0
.end method

.method public r()Ljava/lang/String;
    .locals 1

    const-string v0, "news"

    return-object v0
.end method

.method public s()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/e;->v:Lcom/mg/ola/common/b/d;

    const-string v2, ""

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2, v1}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_1

    invoke-virtual {v2, v3}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    const-string v5, "path"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-nez v0, :cond_0

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5, v1}, Ljava/util/ArrayList;-><init>(I)V

    move-object v0, v5

    :cond_0
    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    return-object v0
.end method

.method public t()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/w;",
            ">;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Lorg/json/JSONArray;

    iget-object v1, p0, Lchat/ola/vn/e;->A:Lcom/mg/ola/common/b/d;

    const-string v2, ""

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_2

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_1

    invoke-virtual {v0, v3}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/entity/w;->a(Lorg/json/JSONObject;)Lchat/ola/vn/entity/w;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    invoke-interface {v2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    new-instance v0, Lchat/ola/vn/e/k;

    invoke-direct {v0}, Lchat/ola/vn/e/k;-><init>()V

    invoke-static {v2, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    :catch_0
    :cond_2
    const/4 v0, 0x0

    return-object v0
.end method

.method public u()Ljava/lang/String;
    .locals 3

    const-string v0, "Ola"

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/e;->D:Lcom/mg/ola/common/b/d;

    const-string v2, "Ola"

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    :catch_0
    return-object v0
.end method

.method public v()Ljava/lang/String;
    .locals 3

    const-string v0, ""

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/e;->E:Lcom/mg/ola/common/b/d;

    const-string v2, ""

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    :catch_0
    return-object v0
.end method

.method public w()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/e;->F:Lcom/mg/ola/common/b/d;

    const-string v3, ""

    invoke-virtual {v2, v3}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3, v2}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-lez v2, :cond_1

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4, v2}, Ljava/util/ArrayList;-><init>(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v2, :cond_0

    :try_start_1
    invoke-virtual {v3, v1}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    move-object v1, v4

    goto :goto_1

    :cond_0
    return-object v4

    :catch_1
    :cond_1
    :goto_1
    :try_start_2
    new-instance v2, Ljava/util/ArrayList;

    const/4 v3, 0x3

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :try_start_3
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v3, 0x7f030016

    invoke-virtual {v1, v3}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v1

    :goto_2
    array-length v3, v1

    if-ge v0, v3, :cond_2

    aget-object v3, v1, v0

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :catch_2
    move-object v2, v1

    :catch_3
    :cond_2
    return-object v2
.end method

.method public x()Ljava/util/List;
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/h;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Lorg/json/JSONArray;

    iget-object v2, p0, Lchat/ola/vn/e;->B:Lcom/mg/ola/common/b/d;

    const-string v3, ""

    invoke-virtual {v2, v3}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-lez v2, :cond_4

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3, v2}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v4, 0x0

    const/4 v5, 0x0

    :goto_0
    if-ge v5, v2, :cond_3

    invoke-virtual {v1, v5}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v6

    const-string v7, "smileyType"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v7

    int-to-short v7, v7

    const/4 v8, 0x1

    if-nez v7, :cond_0

    const-string v9, "smileyTextContent"

    invoke-virtual {v6, v9}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    new-instance v10, Lchat/ola/vn/entry/h;

    invoke-static {}, Lchat/ola/vn/util/h;->a()Lchat/ola/vn/util/h;

    move-result-object v11

    invoke-virtual {v11, v9}, Lchat/ola/vn/util/h;->a(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    move-result v11

    new-array v8, v8, [Ljava/lang/String;

    aput-object v9, v8, v4

    invoke-direct {v10, v11, v7, v8}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    if-ne v7, v8, :cond_1

    const-string v9, "emojiCode"

    invoke-virtual {v6, v9}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v9

    new-instance v10, Lchat/ola/vn/entry/h;

    invoke-static {}, Lchat/ola/vn/util/g;->a()Lchat/ola/vn/util/g;

    move-result-object v11

    invoke-virtual {v11, v9}, Lchat/ola/vn/util/g;->a(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    move-result v11

    new-array v8, v8, [I

    aput v9, v8, v4

    invoke-direct {v10, v11, v7, v8}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    goto :goto_1

    :cond_1
    move-object v10, v0

    :goto_1
    if-eqz v10, :cond_2

    const-string v7, "lastHitTime"

    invoke-virtual {v6, v7}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v6

    iput-wide v6, v10, Lchat/ola/vn/entry/h;->a:J

    invoke-interface {v3, v10}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_2

    invoke-interface {v3, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_3
    new-instance v1, Lchat/ola/vn/e/j;

    invoke-direct {v1}, Lchat/ola/vn/e/j;-><init>()V

    invoke-static {v3, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v3

    :catch_0
    :cond_4
    return-object v0
.end method

.method public y()Ljava/util/List;
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Lorg/json/JSONArray;

    iget-object v1, p0, Lchat/ola/vn/e;->C:Lcom/mg/ola/common/b/d;

    const-string v2, ""

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/b/d;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_2

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_1

    invoke-virtual {v0, v3}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {v5}, Lchat/ola/vn/entity/OlaVenueEntity;-><init>()V

    const-string v6, "venueId"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lchat/ola/vn/entity/OlaVenueEntity;->a(Ljava/lang/String;)V

    const-string v6, "timeStamp"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    const/4 v4, 0x0

    sub-long v10, v8, v6

    const-wide/32 v8, 0x1b77400

    cmp-long v4, v10, v8

    if-lez v4, :cond_0

    goto :goto_1

    :cond_0
    invoke-virtual {v5, v6, v7}, Lchat/ola/vn/entity/OlaVenueEntity;->b(J)V

    invoke-interface {v2, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    return-object v2

    :catch_0
    :cond_2
    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0x14

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    return-object v0
.end method
