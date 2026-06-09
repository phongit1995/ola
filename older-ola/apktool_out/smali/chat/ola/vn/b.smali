.class public Lchat/ola/vn/b;
.super Ljava/lang/Object;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "UseSparseArrays"
    }
.end annotation


# static fields
.field private static a:Lchat/ola/vn/b;


# instance fields
.field private b:[Ljava/lang/String;

.field private c:[Ljava/lang/String;

.field private d:[Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static d()Lchat/ola/vn/b;
    .locals 1

    sget-object v0, Lchat/ola/vn/b;->a:Lchat/ola/vn/b;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/b;

    invoke-direct {v0}, Lchat/ola/vn/b;-><init>()V

    sput-object v0, Lchat/ola/vn/b;->a:Lchat/ola/vn/b;

    :cond_0
    sget-object v0, Lchat/ola/vn/b;->a:Lchat/ola/vn/b;

    return-object v0
.end method


# virtual methods
.method public a()[Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b;->b:[Ljava/lang/String;

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f030020

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/b;->b:[Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b;->b:[Ljava/lang/String;

    return-object v0
.end method

.method public b()[Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b;->c:[Ljava/lang/String;

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f030021

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/b;->c:[Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b;->c:[Ljava/lang/String;

    return-object v0
.end method

.method public c()[Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b;->d:[Ljava/lang/String;

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f030007

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/b;->d:[Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b;->d:[Ljava/lang/String;

    return-object v0
.end method
